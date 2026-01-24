{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
{
  config = mkIf config.moduli.system.stylix.enable {
    environment.systemPackages = [ pkgs.bibata-cursors ];
    stylix = {
      base16Scheme = "${pkgs.base16-schemes}/share/themes/evenok-dark.yaml";
      # base00: "#000000"
      # base01: "#202020"
      # base02: "#303030"
      # base03: "#505050"
      # base04: "#b0b0b0"
      # base05: "#d0d0d0"
      # base06: "#e0e0e0"
      # base07: "#ffffff"
      # base08: "#f5708a"
      # base09: "#ee8122"
      # base0A: "#b8a300"
      # base0B: "#54bc5c"
      # base0C: "#00bab3"
      # base0D: "#00aff2"
      # base0E: "#9095ff"
      # base0F: "#d47ada"

      image = ../wallpaper.png;
      polarity = "dark";
      enableReleaseChecks = false;

      cursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Classic";
        size = 18;
      };

      autoEnable = true;

      homeManagerIntegration = {
        followSystem = true;
        autoImport = true;
      };

      opacity = {
        terminal = 0.75;
        desktop = 0.00;
      };

      fonts = {
        serif = {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrainsMono Mono Nerd Font";
        };

        sansSerif = {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrainsMono Mono Nerd Font";
        };

        monospace = {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrainsMono Mono Nerd Font";
        };

        emoji = {
          package = pkgs.nerd-fonts.symbols-only;
          name = "Symbols Nerd Font";
        };
      };
    };
  };
}
