# Waybar

{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [
          "pulseaudio"
          "network"
          "battery"
        ];
      };
    };
    style = ''
            * {
              font-family: "JetBrainsMono Nerd Font";
              font-size: 12px;
            }
      } 
    '';
  };
}
