{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
{

  config = mkIf config.moduli.system.docker.enable {
    virtualisation.docker = {
      enable = true;
    };
    users.extraGroups.docker.members = [ "andme" ];

    environment.systemPackages = [
      pkgs.docker-compose
      pkgs.freerdp
    ];
  };
}
