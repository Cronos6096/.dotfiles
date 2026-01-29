{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
{
  config = mkIf config.moduli.system.ollama.enable {
    services.ollama = {
      enable = true;
      package = pkgs.ollama-cuda;
    };

    services.open-webui = {
      enable = true;
      openFirewall = true;
    };
  };
}
