{
  inputs,
  lib,
  config,
  ...
}:
with lib;
{
  imports = [ inputs.noctalia.homeModules.default ];

  config = mkIf config.moduli.home-manager.noctalia.enable {
    stylix.targets.noctalia-shell.enable = true;

    programs.noctalia = {
      enable = true;
    };
  };
}
