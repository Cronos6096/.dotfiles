{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
{
  config = mkIf config.moduli.system.solaar.enable {
    services.solaar = {
      enable = true;
      package = pkgs.solaar;
      window = "hide";
      batteryIcons = "regular";
      extraArgs = "";
    };
  };
}
