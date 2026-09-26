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
        x11Support = false;
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

          # Hide Hyprland with USWM
          waylandsessions = "${pkgs.runCommand "ly-wayland-sessions" { } ''
            mkdir -p "$out"
            for pkg in ${
              lib.concatMapStringsSep " " toString config.services.displayManager.sessionPackages
            }; do
              for dir in "$pkg"/share/wayland-sessions; do
                [ -d "$dir" ] || continue
                for f in "$dir"/*.desktop; do
                  [ -e "$f" ] || continue
                  case "''${f##*/}" in
                    hyprland-uwsm.desktop) continue ;;
                  esac
                  ln -s "$f" "$out/''${f##*/}"
                done
              done
            done
          ''}";
        };
      };
    };

    environment.systemPackages = [
      pkgs.brightnessctl
    ];
  };
}
