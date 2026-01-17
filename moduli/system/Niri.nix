{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
{
  config = mkIf config.moduli.system.niri.enable {
    programs.niri = {
      enable = true;
    };
    environment.systemPackages = [ pkgs.xwayland-satellite ];
  };
}
