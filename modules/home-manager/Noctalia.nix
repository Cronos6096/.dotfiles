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
    programs.noctalia = {
      enable = true;
    };
  };
}
