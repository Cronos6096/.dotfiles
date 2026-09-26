{ lib, config, ... }:
with lib;
{
  config = mkIf config.moduli.home-manager.direnv.enable {
    programs.direnv = {
      enable = true;
      # enableFishIntegration = true;
    };
  };
}
