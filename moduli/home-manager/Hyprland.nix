{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
with lib;
{
  config = mkIf config.moduli.home-manager.hyprland.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      settings = {
        xwayland.enable = true;
      };
    };

    home = {
      file."/home/andme/.config/hypr/hyprland.conf".source =
        lib.mkForce ../../moduli/wm/hypr/hyprland.conf;
      file."/home/andme/.config/hypr/pyprland.toml".source = ../../moduli/wm/hypr/pyprland.toml;

      packages = with pkgs; [
        wl-clipboard
        clipse
        hyprshot
        pavucontrol
        networkmanager
        handlr
        hyprsome
        pyprland
        jq
        swww
        waypaper
        hyprmon
        bibata-cursors
        vicinae
      ];
    };
  };
}
