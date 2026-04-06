{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
{
  config = mkIf config.moduli.system.ly.enable {
    services = {
      displayManager = {
        enable = true;
        defaultSession = "hyprland";
        autoLogin = {
          enable = true;
          user = "andme";
        };
      };

      displayManager.ly = {
        enable = true;
        settings = {
          animation = "none";

          clear_password = "true";

          battery_id = "BAT0";
          bigclock = "en";
          asterisk = "0x2022";
          blankbox = "true";
          hide_borders = "true";
          hide_version_string = "true";
          hide_key_hints = "true";
          hide_keyboard_locks = "true";
          clock = "en";
        };
      };
    };

    environment.systemPackages = [
      pkgs.brightnessctl
    ];
  };
}
