{ lib, config, ... }:
with lib;
{
  config = mkIf config.moduli.home-manager.wlsunset.enable {
    services.wlsunset = {
      enable = true;
      sunrise = "06:30";
      sunset = "21:30";
    };
  };
}
