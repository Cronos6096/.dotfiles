{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  ly = pkgs.ly.overrideAttrs (oldAttrs: {
    postPatch = "";
    postConfigure = ''
      export ZIG_GLOBAL_CACHE_DIR="$TMPDIR"
      ln -s "${
        pkgs.callPackage (pkgs.path + "/pkgs/by-name/ly/ly/deps.nix") {
          zig = pkgs.zig_0_15;
        }
      }" "$ZIG_GLOBAL_CACHE_DIR/p"
    '';
  });
in
{
  config = mkIf config.moduli.system.ly.enable {
    services = {
      displayManager = {
        enable = true;
        autoLogin = {
          enable = true;
          user = "andme";
        };
      };

      displayManager.ly = {
        enable = true;
        package = ly;
        settings = {
          animation = "none";

          autologin = "andme";
          autologin_session = "/run/current-system/sw/bin/hyprland";
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
