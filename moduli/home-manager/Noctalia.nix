{ lib, config, ... }:
with lib;
{
  config = mkIf config.moduli.home-manager.noctalia.enable {
    stylix.targets.noctalia-shell.enable = true;

    programs.noctalia = {
      enable = true;
    };
  };
}
