{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
{
  config = mkIf config.moduli.system.adb.enable {
    services.udev.packages = [
      pkgs.android-tools
    ];
  };
}
