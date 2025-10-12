{ config, ... }:
{
  programs.waybar = {
    enable = true;
    settings = [
      {
        layer = "top";
        position = "top";
        modules-center = [ "clock" ];
        modules-left = [
          "ext/workspaces"
          "wlr/taskbar"
          "dwl/window"
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
        "dwl/window" = {
          max-length = 64;
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
          format = "{icon} {volume}% {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = "󰟎 {format_source}";
          format-source = " {volume}%";
          format-source-muted = "";
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
          format-plugged = "󱘖 {capacity}%";
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
        "ext/workspaces" = {
          format = "{icon}";
          on-click = "activate";
          format-icons = {
            "active" = "";
            "urgent" = "󰚽";
            "default" = "";
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
        background: none;
      }

      .modules-right {
        padding-left: 5px;
        border-radius: 8px 0 0 8px;
        margin-top: 2px;
        background: #${config.lib.stylix.colors.base00};
      }

      .modules-center {
        padding: 0 10px;
        margin-top: 2px;
        border-radius: 8px;
        background: #${config.lib.stylix.colors.base00};
      }

      .modules-left {
        padding-right: 5px;
        border-radius: 0 8px 8px 0;
        margin-top: 2px;
        background: #${config.lib.stylix.colors.base00};
      }
      #workspaces {
        background: none;
      }

      #workspaces button {
        color: #${config.lib.stylix.colors.base06};
        background: none;
      }

      #workspaces button:hover {
        color: #${config.lib.stylix.colors.base0B};
        background: none;
      }

      #workspaces button.active {
        color: #${config.lib.stylix.colors.base0C};
        background: none;
      }

      tooltip label {
        color: #${config.lib.stylix.colors.base06};
      }

      #window, #pulseaudio, #cpu, #memory, #network, #battery {
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
        background: transparent;
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
