{ pkgs, ... }:
{
  stylix = {
    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
    # base00: "#191724"
    # base01: "#1f1d2e"
    # base02: "#26233a"
    # base03: "#6e6a86"
    # base04: "#908caa"
    # base05: "#e0def4"
    # base06: "#e0def4"
    # base07: "#524f67"
    # base08: "#eb6f92"
    # base09: "#f6c177"
    # base0A: "#ebbcba"
    # base0B: "#31748f"
    # base0C: "#9ccfd8"
    # base0D: "#c4a7e7"
    # base0E: "#f6c177"
    # base0F: "#524f67"

    # base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    # builtins.fetchurl {
    #   url = "https://raw.githubusercontent.com/scottmckendry/cyberdream.nvim/main/extras/base16/cyberdream.yaml";
    #   sha256 = "1bfi479g7v5cz41d2s0lbjlqmfzaah68cj1065zzsqksx3n63znf";
    # };

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
      terminal = 0.75;
      desktop = 0.00;
    };

    fonts = {
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };

      sansSerif = {
        package = pkgs.dejavu_fonts;
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
