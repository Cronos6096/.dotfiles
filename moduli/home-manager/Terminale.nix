{
  pkgs,
  inputs,
  lib,
  config,
  ...
}:
with lib;
let
  shellAliases = {
    ls = "eza";
    ff = "fastfetch";
    rebuild = "nh os switch ~/.dotfiles/ -H GiovanGianFranco --update";
    rb = "rebuild";
    rbpi = "sudo nixos-rebuild switch --flake ~/.dotfiles/#rpi5 --target-host andme@192.168.1.167 --use-remote-sudo";
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
  config = mkIf config.moduli.home-manager.terminale.enable {
    programs = {
      # Nh
      nh = {
        enable = true;
        clean.enable = true;
        clean.extraArgs = "--keep-since 1d --keep 3";
        flake = "/home/andme/.dotfiles/";
      };

      fish = {
        enable = true;
        inherit shellAliases;
        interactiveShellInit = ''
            set fish_greeting
            ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
            if test -f /run/agenix/envVars
            while read -l line
              set line (string trim -- $line)
              if string match -qr '^[^#=]' -- $line
                set -l parts (string split -m1 '=' -- $line)
                set -gx (string trim -- $parts[1]) $parts[2]
              end
            end < /run/agenix/envVars
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

    programs.nix-index-database.comma.enable = true;
    programs.nix-index.enable = true;

    home.packages = with pkgs; [
      any-nix-shell
      fzf
      git
      links2
      ncdu
      dysk
      tealdeer
      wget
      ripgrep
      which
      bat
      eza
      fd
      inputs.nix-alien.packages.${pkgs.system}.default

      unp
      unrar
      unzip
      xz
      zip
    ];
  };
}
