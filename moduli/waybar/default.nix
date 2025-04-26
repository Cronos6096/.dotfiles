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
          format = "{name}";
          format-icons = {
            default = " ";
            active = " ";
            urgent = "!";
          };
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
        };
        "clock" = {
          format = ''{:L%H:%M:%S}'';
          tooltip = true;
          tooltip-format = "<big>{:%A, %d.%B %Y }</big>\n<tt>{calendar}</tt>";
        };
        "hyprland/window" = {
          max-length = 40;
          separate-outputs = false;
        };
       "network" = {
          format-icons = [
            "󰤯"
            "󰤟"
            "󰤢"
            "󰤥"
            "󰤨"
          ];
          format-ethernet = " {bandwidthDownOctets}";
          format-wifi = "{icon} {signalStrength}%";
          format-disconnected = "󰤮";
          tooltip = false;
        };
        "tray" = {
          spacing = 12;
        };
        "pulseaudio" = {
          format = "{icon} {volume}% {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = " {format_source}";
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
        font-family: JetBrainsMono Nerd Font Mono;
        font-size: 14px;
        border-radius: 0px;
        border: none;
        min-height: 20px; 
      }
      window#waybar {
        background:rgba(0, 0, 0, 0.1);
        border: none;
      }
      #workspaces {
        color: #${config.lib.stylix.colors.base01};
        background: #${config.lib.stylix.colors.base01};
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
        background: #${config.lib.stylix.colors.base0D};
        opacity: 0.5;
        transition: ${betterTransition};
      }
      #workspaces button.active {
        font-weight: bold;
        padding: 0px 5px;
        margin: 0px 3px;
        border-radius: 16px;
        color: #${config.lib.stylix.colors.base00};
        background: #${config.lib.stylix.colors.base0D};
        transition: ${betterTransition};
        opacity: 1.0;
        min-width: 40px;
      }
      #workspaces button:hover {
        font-weight: bold;
        border-radius: 16px;
        color: #${config.lib.stylix.colors.base00};
        background: #${config.lib.stylix.colors.base0D};
        opacity: 0.8;
        transition: ${betterTransition};
      }
      tooltip {
        background: #${config.lib.stylix.colors.base00};
        border: 1px solid #${config.lib.stylix.colors.base04};
        border-radius: 12px;
      }
      tooltip label {
        color: #${config.lib.stylix.colors.base04};
      }
      #window, #pulseaudio, #cpu, #memory, #network, #tray, #battery {
        font-weight: bold;
        margin: 4px 0px;
        margin-left: 7px;
        padding: 0px 8px;
        background: #${config.lib.stylix.colors.base01};
        color: #${config.lib.stylix.colors.base07};
        border-radius: 8px;
      }
      #clock {
        font-weight: bold;
        color: #0D0E15;
        background: #${config.lib.stylix.colors.base0D};
        margin: 2px;
        padding: 4px;
        border-radius: 16px;
      }
    '';
  };
}
