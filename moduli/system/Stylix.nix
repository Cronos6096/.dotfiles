{ pkgs, ... }:
{
  stylix = {
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    # base00: "#1d2021"
    # base01: "#3c3836"
    # base02: "#504945"
    # base03: "#665c54"
    # base04: "#bdae93"
    # base05: "#d5c4a1"
    # base06: "#ebdbb2"
    # base07: "#fbf1c7"
    # base08: "#fb4934"
    # base09: "#fe8019"
    # base0A: "#fabd2f"
    # base0B: "#b8bb26"
    # base0C: "#8ec07c"
    # base0D: "#83a598"
    # base0E: "#d3869b"
    # base0F: "#d65d0e"

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
        name = "JetBrains Mono Nerd Fonts";
      };

      sansSerif = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrains Mono Nerd Fonts";
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
