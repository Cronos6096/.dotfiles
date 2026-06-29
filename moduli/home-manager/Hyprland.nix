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
      configType = "hyprlang";
    };
    home = {
      file = {
        ".config/hypr/autostart.lua".source = mkForce (
          config.lib.file.mkOutOfStoreSymlink ./../wm/hypr/autostart.lua
        );
        ".config/hypr/env.lua".source = mkForce (config.lib.file.mkOutOfStoreSymlink ./../wm/hypr/env.lua);
        ".config/hypr/hyprland.lua".source = mkForce (
          config.lib.file.mkOutOfStoreSymlink ./../wm/hypr/hyprland.lua
        );
        ".config/hypr/looks.lua".source = mkForce (
          config.lib.file.mkOutOfStoreSymlink ./../wm/hypr/looks.lua
        );
        ".config/hypr/keybinds.lua".source = mkForce (
          config.lib.file.mkOutOfStoreSymlink ./../wm/hypr/keybinds.lua
        );
        ".config/hypr/monitors.lua".source = mkForce (
          config.lib.file.mkOutOfStoreSymlink ./../wm/hypr/monitors.lua
        );
        ".config/pypr/config.toml".source = mkForce (
          config.lib.file.mkOutOfStoreSymlink ./../wm/pypr/config.toml
        );
      };

      packages = with pkgs; [
        awww
        bibata-cursors
        clipse
        hyprmon
        hyprshot
        hyprshutdown
        hyprsome
        jq
        networkmanager
        pyprland
        vicinae
        waypaper
        wl-clipboard
      ];
    };
  };
}
