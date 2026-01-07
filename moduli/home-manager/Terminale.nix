{
  pkgs,
  inputs,
  config,
  ...
}:
let
  shellAliases = {
    ls = "eza";
    ff = "fastfetch";
    rebuild = "nh os switch ~/.dotfiles/ -H GiovanGianFranco --update";
    rb = "rebuild";
    rbpi = "sudo nixos-rebuild switch --flake .#rpi5 --target-host root@192.168.1.167 --build-host root@192.168.1.167 --sudo";
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
    ssh = "kitten ssh";

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
        ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
        if test -f /run/agenix/envVars
          source /run/agenix/envVars
        end
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

    nix-search-tv = {
      enable = true;
      package = inputs.nix-search-tv.packages.${pkgs.system}.default;
    };

    zellij = {
      enable = true;
      # enableFishIntegration = true;
      # attachExistingSession = true;
      extraConfig = ''
        simplified_ui true
        pane_frames false
        show_startup_tips false

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
