{pkgs, ...}:

{
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/da-one-black.yaml";

  stylix.image = ./wallpaper.jpg;
  stylix.polarity = "dark";

  stylix.cursor.package = pkgs.bibata-cursors;
  stylix.cursor.name = "Bibata-Modern-Ice";

  stylix.autoEnable = true;
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
