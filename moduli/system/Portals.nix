{ pkgs, ... }:
{
  xdg = {
    portal = {
      enable = true;
       xdgOpenUsePortal = false;
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-gtk
      ];
      config =
        let
          hyprlandPortalPreferences = {
            default = [ "hyprland" "gtk" ];
            "org.freedesktop.impl.portal.Screenshot" = "hyprland";
            "org.freedesktop.impl.portal.Screencast" = "hyprland";
            "org.freedesktop.impl.portal.FileChooser" = "gtk";
            "org.freedesktop.impl.portal.OpenURI" = "gtk";
          };
        in
        {
          common = hyprlandPortalPreferences;
          Hyprland = hyprlandPortalPreferences;
          hyprland = hyprlandPortalPreferences;
        };
    };

    menus.enable = true;
    mime.enable = true;
  };

  services.dbus.enable = true;
}
