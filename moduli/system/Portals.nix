{ pkgs, ... }:
{
  xdg = {
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal
        kdePackages.xdg-desktop-portal-kde
        xdg-desktop-portal-wlr
      ];
    };

    menus.enable = true;
    mime.enable = true;
  };

  services.dbus.enable = true;
}
