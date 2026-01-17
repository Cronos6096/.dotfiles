{ lib, config, ... }:
with lib;
{
  config = mkIf config.moduli.system.plasma.enable {
    services.desktopManager.plasma6.enable = true;
  };
}
