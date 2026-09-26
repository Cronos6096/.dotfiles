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
          config.lib.file.mkOutOfStoreSymlink ./hyprland/autostart.lua
        );
        ".config/hypr/env.lua".source = mkForce (config.lib.file.mkOutOfStoreSymlink ./hyprland/env.lua);
        ".config/hypr/hyprland.lua".source = mkForce (
          config.lib.file.mkOutOfStoreSymlink ./hyprland/hyprland.lua
        );
        ".config/hypr/looks.lua".source = mkForce (
          config.lib.file.mkOutOfStoreSymlink ./hyprland/looks.lua
        );
        ".config/hypr/keybinds.lua".source = mkForce (
          config.lib.file.mkOutOfStoreSymlink ./hyprland/keybinds.lua
        );
        ".config/hypr/monitors.lua".source = mkForce (
          config.lib.file.mkOutOfStoreSymlink ./hyprland/monitors.lua
        );
        ".config/pypr/config.toml".source = mkForce (
          config.lib.file.mkOutOfStoreSymlink ./hyprland/pyprland.toml
        );
      };

      # Every external command invoked from hyprland/*.lua must be on PATH.
      packages = with pkgs; [
        awww
        bibata-cursors
        brightnessctl
        clipse
        hyprmon
        hyprpolkitagent
        hyprshot
        hyprshutdown
        hyprsome
        jq
        kdePackages.kdeconnect-kde # kdeconnectd
        networkmanager
        pyprland
        udiskie
        vicinae
        waypaper
        wireplumber # wpctl
        wl-clipboard
      ];
    };
  };
}
