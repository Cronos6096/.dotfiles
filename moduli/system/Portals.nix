{ pkgs, ... }:
{
  xdg = {
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
        kdePackages.xdg-desktop-portal-kde
      ];
      config = {
        common = {
          default = [ "kde" ];
          "org.freedesktop.impl.portal.FileChooser" = "kde";
        };
        hyprland = {
          default = [ "hyprland" "kde" ];
          "org.freedesktop.impl.portal.Screenshot" = "hyprland";
          "org.freedesktop.impl.portal.Screencast" = "hyprland";
          "org.freedesktop.impl.portal.FileChooser" = "kde";
        };
      };
    };

    menus.enable = true;
    mime.enable = true;
  };

  services.dbus.enable = true;
}
