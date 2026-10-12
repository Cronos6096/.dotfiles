{ config, ... }:
{
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };

  services.fail2ban = {
    enable = true;
    bantime-increment.enable = true;
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

  security.acme = {
    acceptTerms = true;
    defaults.email = "and.merciaro@gmail.com";
    certs."homeassistant.casindra.duckdns.org" = {
      dnsProvider = "duckdns";
      credentialFiles.DUCKDNS_TOKEN_FILE = config.age.secrets.duckdnsToken.path;
      group = "nginx";
    };
  };

  services = {
    nginx = {
      enable = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;
      recommendedGzipSettings = true;
      recommendedOptimisation = true;

      virtualHosts = {
        "_" = {
          default = true;
          rejectSSL = true;
          listen = [
            {
              addr = "0.0.0.0";
              port = 443;
              ssl = true;
            }
            {
              addr = "[::]";
              port = 443;
              ssl = true;
            }
          ];
        };

        "homeassistant.casindra.duckdns.org" = {
          useACMEHost = "homeassistant.casindra.duckdns.org";
          onlySSL = true;
          locations."/" = {
            proxyPass = "http://127.0.0.1:8123";
            proxyWebsockets = true;
          };
        };
      };
    };

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
