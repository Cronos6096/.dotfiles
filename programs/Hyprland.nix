{pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = "";
  };

  programs.waybar = {
    enable = true;
    extraConfig = ''
      {
        "layers": ["shell", "top", "overlay", "bottom"],
        "position": "bottom",
        "modules-left": ["sway/workspaces", "sway/window-title", "sway/tray", "sway/outputs"],
        "modules-center": ["custom/date", "custom/time"],
        "modules-right": ["custom/battery", "custom/memory", "custom/cpu", "custom/temperature", "custom/volume", "custom/network", "custom/updates"],
        "custom/date": {
          "format": "%a %d %b %Y"
        },
        "custom/time": {
          "format": "%H:%M"
        },
        "custom/battery": {
          "format": " {capacity}%"
        },
        "custom/memory": {
          "format": " {used} MiB"
        },
        "custom/cpu": {
          "format": " {usage}%"
        },
        "custom/temperature": {
          "format": " {temperature}°C"
        },
        "custom/volume": {
          "format": " {volume}%"
        },
        "custom/network": {
          "format": " {ssid}"
        },
        "custom/updates": {
          "format": " {count}"
        }
      }
    '';
    style = "";
    # systemd.target = "";
  };
}
