{ pkgs, ... }: 

{
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/da-one-black.yaml";

  stylix.image = ./wallpaper.jpg;
  stylix.polarity = "dark";
  
  stylix.cursor.package = pkgs.bibata-cursors;
  stylix.cursor.name = "Bibata-Modern-Ice"; 
  
  stylix.autoEnable = true;
  stylix.cursor.size = 18;

  #stylix.targets.floorp.enable = true;
  #stylix.targets.floorp.profileNames = [ "default" ];
}
