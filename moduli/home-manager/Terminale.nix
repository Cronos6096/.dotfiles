{ pkgs, ... }:
let
  shellAliases = {
    ls = "eza";
    ff = "fastfetch";
    rebuild = "nh os switch ~/.dotfiles/ -H GiovanGianFranco --update";
    rb = "rebuild";
    rbc = "rebuild && clean";
    rebuildnoup = "nh os switch ~/.dotfiles/ -H GiovanGianFranco";
    rebuildpush = " cdconf && git add * && git commit && git push && nh os switch . -H GiovanGianFranco";
    clean = "nh clean all";
    cdconf = "z ~/.dotfiles";
    cdpr = "z ~/progetti";
    v = "nvim";
    py = "python";
    py3 = "python3";
    ns = "nix-search-tv print | fzf --preview 'nix-search-tv preview {}' --scheme history";
    gas = "git add * && git stage *";
    zj = "zellij";

    cat = "bat";
    find = "fd";
    grep = "rg";
    tree = "eza --git --icons --tree";
  };
in
{
  programs = {
    # Nh
    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 1d --keep 3";
      flake = "~/.dotfiles/";
    };

    fish = {
      enable = true;
      inherit shellAliases;
      interactiveShellInit = ''
        set fish_greeting
        set -x OPENAI_API_KEY (cat /run/secrets.d/openAiToken)
      '';
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };

    starship = {
      enableFishIntegration = true;
      enable = true;
    };

    zellij = {
      enable = true;
      enableFishIntegration = true;
      attachExistingSession = true;
      extraConfig = ''
        simplified_ui true
        pane_frames false

        ui {
            pane_frames {
                rounded_corners true
                hide_session_name true
            }
        }
      '';
    };
  };
}
