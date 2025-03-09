{ pkgs, ... }: 

{
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/evenok-dark.yaml";

# Don't forget to apply wallpaper
  stylix.image = ./wallpaper.jpg;
  stylix.polarity = "dark";
  
  stylix.cursor.package = pkgs.bibata-cursors;
  stylix.cursor.name = "Bibata-Modern-Ice"; 
  
  stylix.autoEnable = true;
}
