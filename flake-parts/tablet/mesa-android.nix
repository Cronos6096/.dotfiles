{
  stdenv,
  fetchurl,
}:
stdenv.mkDerivation rec {
  pname = "mesa-android-kgsl";
  version = "26.3.0-devel-20260824";

  src = fetchurl {
    url = "https://github.com/lfdevs/mesa-for-android-container/releases/download/mesa-${version}/mesa-for-android-container_${version}_ubuntu_noble_arm64.tar.gz";
    sha256 = "06c31d6dd9a404d5f650cfe506521c3c64dc2022a82f12545d0acbcb4544e137";
  };

  dontConfigure = true;
  dontBuild = true;
  dontFixup = true;
  dontStrip = true;
  sourceRoot = ".";

  installPhase = ''
    runHook preInstall
    mkdir -p "$out"
    tar xzf "$src" -C "$out"
    sed -i 's#/usr/lib/aarch64-linux-gnu#${placeholder "out"}/usr/lib/aarch64-linux-gnu#g' \
      "$out/usr/share/vulkan/icd.d/"*.json
    runHook postInstall
  '';
}
