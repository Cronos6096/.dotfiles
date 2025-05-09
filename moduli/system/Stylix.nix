{ pkgs, ... }:
{
  # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/helios.yaml";
  # https://tinted-theming.github.io/tinted-gallery/

  stylix.image = ./wallpaper.jpg;
  stylix.polarity = "dark";

  stylix.cursor.package = pkgs.bibata-cursors;
  stylix.cursor.name = "Bibata-Modern-Ice";

  stylix.autoEnable = true;

  stylix.opacity = {
    desktop = 0.0;
    terminal = 0.9;
  };

  stylix.targets = {
    plymouth.enable = false;
  };

  stylix.cursor.size = 18;

  stylix.fonts = {
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
}
