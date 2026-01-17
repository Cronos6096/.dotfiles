{ lib, config, ... }:
with lib;
{
  config = mkIf config.moduli.home-manager.rofi.enable {
    programs.rofi.enable = true;

    home.file = {
      "/home/andme/.config/rofi/config.rasi".source = ./config.rasi;
      "/home/andme/.config/rofi/colors.rasi".source = ./colors.rasi;
      "/home/andme/.config/rofi/fonts.rasi".source = ./fonts.rasi;
      "/home/andme/.config/rofi/style.rasi".source = ./style.rasi;
    };
  };
}
