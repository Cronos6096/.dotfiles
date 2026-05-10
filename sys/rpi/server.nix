{ config, ... }:
{
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };

  users.users.andme.extraGroups = [ "docker" ];

  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      crafty = {
        image = "registry.gitlab.com/crafty-controller/crafty-4:latest";
        autoStart = true;

        environment = {
          TZ = "Europe/Rome";
        };

        ports = [
          "8443:8443" # HTTPS
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
          "--network=host"
          "--cap-add=NET_ADMIN"
          "--cap-add=SYS_ADMIN"
        ];
      };

      home-assistant = {
        image = "ghcr.io/home-assistant/home-assistant:stable";
        autoStart = true;

        environment = {
          TZ = "Europe/Rome";
        };

        ports = [
          "8123:8123"
        ];

        volumes = [
          "/var/lib/home-assistant:/config"
        ];

        extraOptions = [
          "--network=host"
          "--cap-add=NET_ADMIN"
          "--cap-add=NET_RAW"
          "--cap-add=SYS_ADMIN"
        ];
      };

      nginx-proxy-manager = {
        image = "jc21/nginx-proxy-manager:latest";
        autoStart = true;
        ports = [
          "80:80"
          "81:81"
          "443:443"
        ];

        environment = {
          TZ = "Europe/Rome";
        };

        volumes = [
          "/var/lib/nginx-proxy-manager/data:/data"
          "/var/lib/nginx-proxy-manager/letsencrypt:/etc/letsencrypt"
        ];
      };
    };
  };

  services = {
    immich = {
      enable = true;
      port = 2283;
      host = "0.0.0.0";
      openFirewall = true;
      environment.IMMICH_LOG_LEVEL = "warn";
      mediaLocation = "/var/lib/immich";
    };

    duckdns = {
      enable = true;
      tokenFile = config.age.secrets.duckdnsToken.path;
      domains = [
        # "serverdiminecraft"
        "casindra"
        "serverdiminchiaft"
      ];
    };
  };
}
