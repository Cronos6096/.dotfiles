#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/.."

CFG="hosts/rpi5/jellyfin-plugin-repos.json"
PINS="hosts/rpi5/nixflix-pins.nix"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

export NIX_CONFIG="${NIX_CONFIG:-experimental-features = nix-command flakes}"

ABI="$(jq -r .jellyfinAbi "$CFG")"
[[ -n "$ABI" && "$ABI" != "null" ]] || { echo "jellyfinAbi missing in $CFG" >&2; exit 1; }

# Pad the ABI to three components (12.4 -> 12.4.0) for release-asset matching.
ABI_TRIPLE="$(jq -rn --arg v "$ABI" '$v | split(".") + [0,0,0] | .[0:3] | join(".")')"

# nix store prefetch-file --json prints { url, hash (SRI), storePath }.
checksum() {
  nix store prefetch-file --json "$1" | jq -r .hash
}

checksum_unpacked() {
  nix store prefetch-file --unpack --json "$1" | jq -r .hash
}

manifest_filter='
def ver: (tostring | split(".") | map(tonumber? // 0));
def vp: (ver + [0,0,0,0])[0:4];
(if type == "array" then . else (.plugins // []) end)
| (map(select(.name == $name)) | first | .versions? // [])
| map(select(((.targetAbi | vp) <= ($abi | vp))))
| sort_by([(.targetAbi | vp), (.version | vp)])
| last
| if . == null then empty else (.version + "\t" + .sourceUrl) end
'

github_filter='
def ver: (tostring | split(".") | map(tonumber? // 0));
def vp: (ver + [0,0,0,0])[0:4];
[ .[]
  | select((.draft != true) and (.prerelease != true)) as $rel
  | $rel.assets[]
  | select(.name | test("^Release-[0-9.]+\\.zip$"))
  | {
      version: $rel.tag_name,
      targetAbi: (.name | capture("^Release-(?<abi>[0-9.]+)\\.zip$").abi),
      sourceUrl: .browser_download_url
    }
]
| map(select(((.targetAbi | vp) <= ($abi | vp))))
| sort_by([(.targetAbi | vp), (.version | vp)])
| last
| if . == null then empty else (.version + "\t" + .sourceUrl) end
'

# Fetch every manifest once; keep the exact bytes that were hashed.
declare -A manifestPaths manifestHashes
repoNames=()
while IFS=$'\t' read -r name url; do
  out="$(nix store prefetch-file --json "$url")"
  sp="$(jq -r .storePath <<<"$out")"
  cp "$sp" "$TMP/$name.json"
  sed -i '1s/^\xEF\xBB\xBF//' "$TMP/$name.json"   # strip BOM if present
  repoNames+=("$name")
  manifestPaths[$name]="$TMP/$name.json"
  manifestHashes[$name]="$(jq -r .hash <<<"$out")"
  echo "manifest $name: ${manifestHashes[$name]}" >&2
done < <(jq -r '.repos | to_entries[] | "\(.key)\t\(.value.url)"' "$CFG")

resolve_plugin() {
  local attr="$1" source
  source="$(jq -r --arg name "$attr" '.plugins[$name] // empty | keys[0] // empty' "$CFG")"
  [[ -n "$source" ]] || { echo "plugin '$attr' has no source configured" >&2; return 1; }

  local row
  if [[ "$source" == "repo" ]]; then
    local repo manifest
    repo="$(jq -r --arg name "$attr" '.plugins[$name].repo' "$CFG")"
    if [[ -z "${manifestPaths[$repo]:-}" ]]; then
      echo "unknown repo '$repo'" >&2
      return 1
    fi
    manifest="${manifestPaths[$repo]}"
    row="$(jq -r --arg name "$attr" --arg abi "$ABI" "$manifest_filter" "$manifest")"
  elif [[ "$source" == "github" ]]; then
    local slug
    slug="$(jq -r --arg name "$attr" '.plugins[$name].github' "$CFG")"
    row="$(curl -sf "https://api.github.com/repos/$slug/releases?per_page=100" \
      | jq -r --arg abi "$ABI" "$github_filter")"
  else
    echo "plugin '$attr': unknown source '$source'" >&2
    return 1
  fi

  if [[ ! "$row" == *$'\t'* ]]; then
    echo "plugin '$attr': no ABI-compatible release found for Jellyfin '$ABI'" >&2
    return 1
  fi
  printf '%s\n' "$row"
}

# Resolve every plugin: "version<TAB>sourceUrl"
declare -a pluginNames
declare -A pluginVersion pluginUrl pluginHash
while IFS=$'\t' read -r attr _; do
  pluginNames+=("$attr")
done < <(jq -r '.plugins | keys[]' "$CFG")

for attr in "${pluginNames[@]}"; do
  row="$(resolve_plugin "$attr")"
  version="${row%%$'\t'*}"
  url="${row#*$'\t'}"
  pluginVersion[$attr]="$version"
  pluginUrl[$attr]="$url"
  pluginHash[$attr]="$(checksum_unpacked "$url")"
  echo "plugin $attr -> $version (${pluginHash[$attr]})" >&2
done

# Render the pins file.
{
  echo "{"
  echo "  manifestHashes = {"
  for name in "${repoNames[@]}"; do
    echo "    $name = \"${manifestHashes[$name]}\";"
  done
  echo "  };"
  echo ""
  echo "  plugins = {"
  for attr in "${pluginNames[@]}"; do
    echo "    \"$attr\" = {"
    echo "      version = \"${pluginVersion[$attr]}\";"
    echo "      url = \"${pluginUrl[$attr]}\";"
    echo "      hash = \"${pluginHash[$attr]}\";"
    echo "    };"
  done
  echo "  };"
  echo "}"
} >"$TMP/nixflix-pins.nix"

# Report change status for CI.
changed=true
if [[ -f "$PINS" ]] && diff -q "$PINS" "$TMP/nixflix-pins.nix" >/dev/null; then
  changed=false
  echo "no changes to $PINS" >&2
else
  mv "$TMP/nixflix-pins.nix" "$PINS"
  echo "updated $PINS" >&2
fi

if [[ -n "${GITHUB_OUTPUT:-}" ]]; then
  echo "changed=$changed" >>"$GITHUB_OUTPUT"
fi
