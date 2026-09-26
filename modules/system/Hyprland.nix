{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
with lib;
{
  config = mkIf config.moduli.system.hyprland.enable {
    programs.hyprland = {
      enable = true;
      # nixpkgs advertises the "hyprland-uwsm" session whenever the package is
      # built with systemd support, which is independent of withUWSM. With
      # withUWSM off, uwsm itself is not installed, so the session is dead on
      # arrival. Worse, it shares DesktopNames=Hyprland with the real session
      # and sorts first in the wayland-sessions directory, so ly's autologin
      # name match lands on it. Advertise only the session that can actually run.
      # This only rewrites a passthru attribute, so the build is unchanged.
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland.overrideAttrs (old: {
        passthru = (old.passthru or { }) // {
          providedSessions = [ "hyprland" ];
        };
      });
      portalPackage =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      xwayland.enable = true;
      withUWSM = false;
    };
  };
}
