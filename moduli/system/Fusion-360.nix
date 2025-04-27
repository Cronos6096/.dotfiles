{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wineWowPackages.stable
    winetricks
    geckodriver
    mono
    cabextract
    p7zip
    curl
    wget
    yad
    glibcLocales
    vkd3d
    dxvk
    mokutil
    gettext
    gawk
    bc
    samba
    lsb-release
  ];

  hardware.graphics.enable = true;
}
