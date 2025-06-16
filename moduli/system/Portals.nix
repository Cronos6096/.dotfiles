{ pkgs, ... }:
{
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
  };

  xdg.menus.enable = true;
  xdg.mime.enable = true;

  services.dbus.enable = true;
}
