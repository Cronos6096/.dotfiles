{ pkgs, ... }:
{
  stylix = {
    base16Scheme = builtins.fetchurl {
      url = "https://raw.githubusercontent.com/scottmckendry/cyberdream.nvim/main/extras/base16/cyberdream.yaml";
      sha256 = "1bfi479g7v5cz41d2s0lbjlqmfzaah68cj1065zzsqksx3n63znf";
    };

    #"${pkgs.base16-schemes}/share/themes/monokai.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/helios.yaml";
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
