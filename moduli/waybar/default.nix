{
  programs.waybar = {
    enable = true;
    settings = {

      mainBar = {
        layer = "top";
        position = "top";
        height = 36;
        modules-left = [
          "hyprland/workspaces"
          "hyprland/window"
        ];
        modules-center = [ "clock" ];
        modules-right = [
          "pulseaudio"
          "network"
          "battery"
        ];
      };

      "hyprland/workspaces" = {
        format = "{icon} {windows}";
        all-outputs = true;
        on-scroll-up = "hyprctl dispatch workspace e+1";
        on-scroll-down = "hyprctl dispatch workspace e-1";
        on-click = "activate";
        window-rewrite-default = "";
        window-rewrite = {
          "class<firefox>" = "";
          "class<kitty>" = "";
          "class<code>" = "";
          "title<.*youtube.*>" = "";
        };
      };

      "hyprland/window" = {
        separate-outputs = true;
        max-length = 80;
      };

      pulseaudio = {
        format = "{icon} {volume}%";
        format-muted = " Muted";
        format-icons = [
          ""
          ""
          ""
        ];
        on-click = "pavucontrol";
      };

      network = {
        format-wifi = " {essid}";
        format-ethernet = "󰈀 Wired";
        format-disconnected = "󰖪 Disconnected";
        tooltip = true;
        on-click = "nm-connection-editor";
      };

      battery = {
        format = "{icon} {capacity}%";
        format-charging = " {capacity}%";
        format-icons = [
          ""
          ""
          ""
          ""
          ""
        ];
        tooltip = true;
      };

      clock = {
        format = " {:%H:%M %S}";
        tooltip-format = "{:%A, %B %d, %Y | %H:%M:%S}";
      };
    };

    style = ''
      * {
        font-family: "JetBrains Nerd Font";
        font-size: 12px;
      }

      window#waybar {
        background-color: rgba(0, 0, 0, 0.4);            
        border: none;
        box-shadow: none;
      }

      #workspaces button {
        padding: 0 5px;
        background: transparent;
        border: none;
      }

      #workspaces button.active {
        background: rgba(255, 255, 255, 0.2);
        border-radius: 4px;
      }

      #clock, #battery, #network, #pulseaudio, #window {
        padding: 0 10px;
      }

      #network.disconnected {
        color: #ff6c6b;
      }

      #tooltip {
        background-color: rgba(0, 0, 0, 0.8);
        color: #e0def4;
        border-radius: 4px;
        padding: 3px 6px;
        font-size: 11px;
     }
    '';
  };
}
