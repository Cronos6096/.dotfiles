{ config, pkgs, lib, inputs, ... }:

{
  options = {
    autoXdgPortal.enable = lib.mkEnableOption "Portale xdg automatico con wayland";
  };

  config = lib.mkIf config.autoXdgPortal.enable {
    environment.systemPackages = with pkgs; [
      xdg-utils
    ];

    xdg.portal = {
      enable = true;
      wlr.enable = true;
      xdgOpenUsePortal = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
      ];
    };

    services.dbus.packages = with pkgs; [
      xdg-desktop-portal
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland
    ];
  };
}
