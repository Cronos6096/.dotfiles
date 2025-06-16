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
                                padding: 2px;
                                background: transparent;
                              }

            		  .modules-right {
            		    padding-left: 5px;
            		    border-radius: 15px 0 0 15px;
            		    margin-top: 2px;
            		    background: #${config.lib.stylix.colors.base00};
            		  }

            		  .modules-center {
            		    padding: 0 15px;
            		    margin-top: 2px;
            		    border-radius: 15px 15px 15px 15px;
            		    background: #${config.lib.stylix.colors.base00};
            		  }

            		  .modules-left {
            		    border-radius: 0 15px 15px 0;
            		    margin-top: 2px;
            		    background: #${config.lib.stylix.colors.base00};
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
                                color: #${config.lib.stylix.colors.base07};
                                margin: 2px;
                                border-radius: 12px;
                              }
    '';
  };
}
