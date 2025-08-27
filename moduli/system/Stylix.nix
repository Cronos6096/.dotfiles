{ pkgs, ... }:
{
  stylix = {
    base16Scheme = "${pkgs.base16-schemes}/share/themes/black-metal-immortal.yaml";
    # base00: "#000000"
    # base01: "#121212"
    # base02: "#222222"
    # base03: "#333333"
    # base04: "#999999"
    # base05: "#c1c1c1"
    # base06: "#999999"
    # base07: "#c1c1c1"
    # base08: "#5f8787"
    # base09: "#aaaaaa"
    # base0A: "#556677"
    # base0B: "#7799bb"
    # base0C: "#aaaaaa"
    # base0D: "#888888"
    # base0E: "#999999"
    # base0F: "#444444"

    # https://tinted-theming.github.io/tinted-gallery/

    image = ./wallpaper.png;
    polarity = "dark";

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 18;
    };

    autoEnable = true;

    opacity = {
      terminal = 0.5;
      desktop = 0.00;
    };

    fonts = {
      serif = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "DejaVu Serif";
      };

      sansSerif = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "DejaVu Sans";
      };

      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrains Mono Nerd Font";
      };

      emoji = {
        package = pkgs.nerd-fonts.symbols-only;
        name = "Symbols Nerd Font";
      };
    };
  };
}
