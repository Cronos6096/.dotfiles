{ config, ... }:
{
  stylix.targets.waybar.enable = false;

  programs.waybar = {
    enable = true;
    settings = [
      {
        layer = "top";
        position = "top";
        modules-center = [ "clock" ];
        modules-left = [
          "hyprland/workspaces"
          "hyprland/window"
          "niri/workspaces"
          "niri/window"
        ];
        modules-right = [
          "network"
          "tray"
          "pulseaudio"
          "battery"
        ];
        "clock" = {
          format = ''{:%Y-%m-%d %T}'';
          interval = 1;
          tooltip = false;
        };
        "hyprland/window" = {
          separate-outputs = true;
        };
        "niri/window" = {
          separate-outputs = true;
        };
        "network" = {
          format-icons = [
            "󰤯"
            "󰤟"
            "󰤢"
            "󰤥"
            "󰤨"
          ];
          format-ethernet = "";
          format-wifi = "{icon} {essid}";
          format-disconnected = "󰤮";
        };
        "tray" = {
          spacing = 12;
          icon-size = 16;
        };
        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-bluetooth = "{volume}% {icon} ";
          format-muted = "󰟎 ";
          format-icons = {
            headphone = "󰋋";
            headset = "󰋎";
            default = [
              ""
              ""
              ""
            ];
          };
          on-click = "pavucontrol";
        };
        "battery" = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-plugged = "󰂄 {capacity}%";
          format-icons = [
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
          on-click = "";
          tooltip = false;
        };
        "hyprland/workspaces" = {
          on-click = "activate";
          "format" = "{icon}";
          "format-icons" = {
            "default" = "";
            "active" = "";
          };
        };
      }
    ];
    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font", "Symbols Nerd Font Mono";
        font-size: 16px;
      }

      window#waybar {
        border-radius: 12px;
        margin-top: 2px;
        background: none;
      }

      .modules-right {
        padding-left: 12px;
        padding-right: 12px;
        border-radius: 8px;
        margin-top: 2px;
        margin-right: 2px;
        background: #${config.lib.stylix.colors.base00};
      }

      .modules-center {
        padding: 0 10px;
        margin-top: 2px;
        border-radius: 8px;
        background: #${config.lib.stylix.colors.base00};
      }

      .modules-left {
        padding-right: 12px;
        border-radius: 8px;
        margin-top: 2px;
        margin-left: 2px;
        background: #${config.lib.stylix.colors.base00};
      }

      #workspaces {
        box-shadow: none;
        text-shadow: none;
        background: none;
      }

      #workspaces button {
        color: #${config.lib.stylix.colors.base06};
        box-shadow: none;
        text-shadow: none;
        transition: all 0.3s ease;
        background: none;
      }

      #workspaces button:hover {
        color: #${config.lib.stylix.colors.base0B};
        transition: all 0.3s ease;
        background: none;
      }

      #workspaces button.active {
        color: #${config.lib.stylix.colors.base0C};
        transition: all 0.3s ease;
        background: none;
      }

      tooltip label {
        color: #${config.lib.stylix.colors.base06};
      }

      #window, #pulseaudio, #battery {
        margin: 4px 0px;
        margin-left: 7px;
        color: #${config.lib.stylix.colors.base06};
        border-radius: 8px;
      }

      #tray {
        background: #${config.lib.stylix.colors.base02};
        padding: 6px;
        border-radius: 8px;
        margin: 4px;
      }

      #tray menu {
        color: #${config.lib.stylix.colors.base06};
        background: #${config.lib.stylix.colors.base02};
        border-radius: 8px;
      }

      #clock {
        font-weight: bold;
        color: #${config.lib.stylix.colors.base06};
        margin: 2px;
      }
    '';
  };
}
