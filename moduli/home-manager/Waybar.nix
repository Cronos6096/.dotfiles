{ config, ... }:
let
  betterTransition = "all 0.3s cubic-bezier(.55,-0.68,.48,1.682)";
in
{
  programs.waybar = {
    enable = true;
    settings = [
      {
        layer = "top";
        position = "top";
        modules-center = [ "hyprland/window" ];
        modules-left = [
          "pulseaudio"
          "hyprland/workspaces"
        ];
        modules-right = [
          "network"
          "battery"
          "tray"
          "clock"
        ];
        "hyprland/workspaces" = {
          format = "·";
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
        };
        "clock" = {
          format = ''{:%Y-%m-%d %T}'';
          interval = 1;
          tooltip = false;
        };
        "hyprland/window" = {
          max-length = 40;
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
          format-ethernet = " {bandwidthTotalBytes}";
          format-wifi = "{icon} {essid} {bandwidthTotalBytes}";
          format-disconnected = "󰤮";
        };
        "tray" = {
          spacing = 12;
          icon-size = 16;
        };
        "pulseaudio" = {
          format = "{icon} {volume}% {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = " {format_source}";
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
        font-family: Jet Brains Mono;
        font-size: 16px;
      }
      window#waybar {
        background:rgba(0, 0, 0, 0.75);
        padding: 2px;
      }
      #workspaces {
        color: #${config.lib.stylix.colors.base00};
        background: #${config.lib.stylix.colors.base00};
        margin: 4px 4px;
        padding: 5px 5px;
        border-radius: 8px;
      }
      #workspaces button {
        font-weight: bold;
        padding: 0px 5px;
        margin: 0px 3px;
        border-radius: 8px;
        color: #${config.lib.stylix.colors.base00};
        background: #${config.lib.stylix.colors.base0B};
        opacity: 0.5;
        transition: ${betterTransition};
      }
      #workspaces button.active {
        font-weight: bold;
        padding: 0px 5px;
        margin: 0px 3px;
        border-radius: 16px;
        color: #${config.lib.stylix.colors.base00};
        background: #${config.lib.stylix.colors.base06};
        transition: ${betterTransition};
        opacity: 1.0;
        min-width: 40px;
      }
      #workspaces button:hover {
        font-weight: bold;
        border-radius: 16px;
        color: #${config.lib.stylix.colors.base00};
        background: #${config.lib.stylix.colors.base0B};
        opacity: 0.8;
        transition: ${betterTransition};
      }
      tooltip label {
        color: #${config.lib.stylix.colors.base04};
      }
      #window, #pulseaudio, #cpu, #memory, #network, #tray, #battery {
        margin: 4px 0px;
        margin-left: 7px;
        color: #${config.lib.stylix.colors.base07};
        border-radius: 8px;
      }
      #tray menu {
         color: #${config.lib.stylix.colors.base00};
	 border-radius: 8px;
      }
      #clock {
        font-weight: bold;
        color: #${config.lib.stylix.colors.base08};
        margin: 2px;
        border-radius: 12px;
      }
    '';
  };
}
