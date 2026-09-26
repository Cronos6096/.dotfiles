{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
{
  config = mkIf config.moduli.system.ai.enable {
    environment.systemPackages = with pkgs; [
      lmstudio
    ];
  };
}
