{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    autoXdgPortal.enable = lib.mkEnableOption "Portale xdg automatico con wayland";
  };

  config = lib.mkIf config.autoXdgPortal.enable {
    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal
        xdg-desktop-portal-hyprland
        kdePackages.xdg-desktop-portal-kde
      ];
    };

    services.dbus.packages = with pkgs; [
      xdg-desktop-portal
    ];
  };
}
