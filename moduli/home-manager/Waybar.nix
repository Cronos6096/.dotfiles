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
          "hyprland/workspaces"
          "tray"
          "hyprland/window"
        ];
        modules-right = [
          "network"
          "pulseaudio"
          "battery"
        ];
        "clock" = {
          format = ''{:%Y-%m-%d %T}'';
          interval = 1;
          tooltip = false;
        };
        "hyprland/window" = {
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
          format-bluetooth-muted = "{icon} {format_source}";
          format-muted = "{format_source}";
          format-source = " {volume}%";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
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
      }
    ];
    style = ''
      * {
        font-family: "JetBrains Mono Nerd Font", "Symbols Nerd Font Mono";
        font-size: 16px;
      }

      window#waybar {
        background: transparent;
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

      tooltip label {
        color: #${config.lib.stylix.colors.base07};
      }

      #window, #pulseaudio, #cpu, #memory, #network, #battery {
        margin: 4px 0px;
        margin-left: 7px;
        color: #${config.lib.stylix.colors.base07};
        border-radius: 8px;
      }

      #tray {
        color: #${config.lib.stylix.colors.base03};
        border-radius: 8px;
        margin: 4px;
      }

      #tray menu {
        color: #${config.lib.stylix.colors.base07};
        background: transparent;
        border-radius: 8px;
      }

      #clock {
        font-weight: bold;
        color: #${config.lib.stylix.colors.base07};
        margin: 2px;
      }
    '';
  };
}
