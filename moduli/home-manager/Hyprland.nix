{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
{
  config = mkIf config.moduli.home-manager.hyprland.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      package = null;
      portalPackage = null;
    };
    home = {
      file = {
        "/home/andme/.config/hypr/autostart.lua".source = mkForce (
          config.lib.file.mkOutOfStoreSymlink "../wm/hypr/autostart.lua"
        );
        "/home/andme/.config/hypr/env.lua".source = mkForce (
          config.lib.file.mkOutOfStoreSymlink "../wm/hypr/env.lua"
        );
        "/home/andme/.config/hypr/hyprland.lua".source = mkForce (
          config.lib.file.mkOutOfStoreSymlink "../wm/hypr/hyprland.lua"
        );
        "/home/andme/.config/hypr/looks.lua".source = mkForce (
          config.lib.file.mkOutOfStoreSymlink "../wm/hypr/looks.lua"
        );
        "/home/andme/.config/hypr/monitors.lua".source = mkForce (
          config.lib.file.mkOutOfStoreSymlink "../wm/hypr/monitors.lua"
        );
        "/home/andme/.config/pypr/config.toml".source = mkForce (
          config.lib.file.mkOutOfStoreSymlink "..wm/hypr/pyprland.toml"
        );
      };
      packages = with pkgs; [
        wl-clipboard
        clipse
        hyprshot
        networkmanager
        hyprsome
        pyprland
        jq
        awww
        waypaper
        hyprmon
        bibata-cursors
        vicinae
      ];
    };
  };
}
