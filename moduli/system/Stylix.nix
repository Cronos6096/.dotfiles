{ pkgs, ... }:
{
  stylix = {
    base16Scheme = "${pkgs.base16-schemes}/share/themes/oxocarbon-dark.yaml";

    #   palette:
    # base00: #161616
    # base01: #262626
    # base02: #393939
    # base03: #525252
    # base04: #dde1e6
    # base05: #f2f4f8
    # base06: #ffffff
    # base07: #08bdba
    # base08: #3ddbd9
    # base09: #78a9ff
    # base0A: #ee5396
    # base0B: #33b1ff
    # base0C: #ff7eb6
    # base0D: #42be65
    # base0E: #be95ff
    # base0F: #82cfff

    # builtins.fetchurl {
    #   url = "https://raw.githubusercontent.com/scottmckendry/cyberdream.nvim/main/extras/base16/cyberdream.yaml";
    #   sha256 = "1bfi479g7v5cz41d2s0lbjlqmfzaah68cj1065zzsqksx3n63znf";
    # };

    # https://tinted-theming.github.io/tinted-gallery/

    image = ./wallpaper.png;
    polarity = "dark";

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 18;
    };

    autoEnable = true;

    opacity = {
      terminal = 0.75;
      desktop = 0.00;
    };

    targets = {
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
        package = pkgs.fira-code;
        name = "Jet Brains Mono";
      };
    };
  };
}
