{ pkgs, ... }:
{
  virtualisation.docker = {
    enable = true;
  };
  users.extraGroups.docker.members = [ "andme" ];

  environment.systemPackages = [ pkgs.docker-compose ];
}
