{ pkgs, lib, config, ... }:

{
  options = {
    autoXdgPortal.enable = lib.mkEnableOption "Portale xdg automatico con wayland";
  };

  config = lib.mkIf config.autoXdgPortal.enable {
    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-gtk
      ];
    };

    services.dbus.packages = with pkgs; [
      xdg-desktop-portal
    ];
  };
}
