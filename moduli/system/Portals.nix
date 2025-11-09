{ pkgs, ... }:
{
  xdg = {
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal
        xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
      ];
    };

    menus.enable = true;
    mime.enable = true;
  };

  services.dbus.enable = true;
}
