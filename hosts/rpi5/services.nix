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
    };
  };

  services = {
    duckdns = {
      enable = true;
      tokenFile = config.age.secrets.duckdnsToken.path;
      domains = [
        "casindra"
        "serverdiminchiaft"
      ];
    };
  };
}
