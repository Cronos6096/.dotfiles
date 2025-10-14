{ lib, ... }:
{
  programs.rofi.enable = true;

  home.file = {
    "/home/andme/.config/rofi/config.rasi".source = lib.mkForce ./config.rasi;
    "/home/andme/.config/rofi/colors.rasi".source = lib.mkForce ./colors.rasi;
    "/home/andme/.config/rofi/fonts.rasi".source = lib.mkForce ./fonts.rasi;
    "/home/andme/.config/rofi/style.rasi".source = lib.mkForce ./style.rasi;
  };
}
