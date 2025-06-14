{ pkgs, ... }:
{
  stylix = {
    base16Scheme = "${pkgs.base16-schemes}/share/themes/monokai.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/helios.yaml";
    # https://tinted-theming.github.io/tinted-gallery/

    image = ./wallpaper.jpg;
    polarity = "dark";

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 18;
    };

    autoEnable = true;

    opacity = {
      terminal = 0.75;
      desktop = 0.75;
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
        name = "Fira Code";
      };
    };
  };
}
