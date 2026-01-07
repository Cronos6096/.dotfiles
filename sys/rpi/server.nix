{ config, ... }:
{
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };

  users.users.andme.extraGroups = [ "docker" ];

  virtualisation.oci-containers = {
    backend = "docker";
    containers.crafty = {
      image = "registry.gitlab.com/crafty-controller/crafty-4:latest";
      autoStart = true;

      environment = {
        TZ = "Europe/Rome";
      };

      ports = [
        "8443:8443" # HTTPS
        "8123:8123" # Dynmap
        "19132:19132/udp" # Bedrock
        "25500-25600:25500-25600" # Java MC port range
      ];

      volumes = [
        "/var/lib/crafty/backups:/crafty/backups"
        "/var/lib/crafty/logs:/crafty/logs"
        "/var/lib/crafty/servers:/crafty/servers"
        "/var/lib/crafty/config:/crafty/app/config"
        "/var/lib/crafty/import:/crafty/import"
      ];

      extraOptions = [
        "--cap-add=NET_ADMIN"
        "--cap-add=SYS_ADMIN"
      ];
    };
  };

  services.duckdns = {
    enable = true;
    tokenFile = ./tokenFile;
    domains = [ "serverdiminecraft" ];
  };
}
