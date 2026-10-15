{
  config,
  inputs,
  lib,
  ...
}:
let
  domain = "casindra.duckdns.org";

  lanOnly = ''
    allow 127.0.0.1;
    allow ::1;
    allow 10.0.0.0/8;
    allow 172.16.0.0/12;
    allow 192.168.0.0/16;
    allow fc00::/7;
    allow fe80::/10;
    deny all;
  '';

  restrictedSubdomains = [
    "prowlarr"
    "radarr"
    "sonarr"
    "torrent"
  ];
in
{
  imports = [ inputs.nixflix.nixosModules.default ];

  nixpkgs.overlays = [
    (
      _final: prev:
      let
        unstable = inputs.nixpkgs.legacyPackages.${prev.stdenv.hostPlatform.system};
      in
      {
        jellyfin = unstable.jellyfin;
        jellyfin-web = unstable.jellyfin-web;
        jellyfin-ffmpeg = unstable.jellyfin-ffmpeg;
        sonarr = unstable.sonarr;
        radarr = unstable.radarr;
        prowlarr = unstable.prowlarr;
        seerr = unstable.seerr;
        recyclarr = unstable.recyclarr;
        qbittorrent-nox = unstable.qbittorrent-nox;
      }
    )
  ];

  age.secrets = {
    nixflix-jellyfin-admin-password.file = ../../secrets/nixflix/jellyfin-admin-password.age;
    nixflix-jellyfin-api-key.file = ../../secrets/nixflix/jellyfin-api-key.age;
    nixflix-prowlarr-api-key.file = ../../secrets/nixflix/prowlarr-api-key.age;
    nixflix-prowlarr-password.file = ../../secrets/nixflix/prowlarr-password.age;
    nixflix-radarr-api-key.file = ../../secrets/nixflix/radarr-api-key.age;
    nixflix-radarr-password.file = ../../secrets/nixflix/radarr-password.age;
    nixflix-qbittorrent-password.file = ../../secrets/nixflix/qbittorrent-password.age;
    nixflix-seerr-api-key.file = ../../secrets/nixflix/seerr-api-key.age;
    nixflix-sonarr-api-key.file = ../../secrets/nixflix/sonarr-api-key.age;
    nixflix-sonarr-password.file = ../../secrets/nixflix/sonarr-password.age;
  };

  nixflix = {
    enable = true;
    mediaDir = "/data/media";
    downloadsDir = "/data/downloads";
    mediaUsers = [ "andme" ];

    nginx = {
      enable = true;
      inherit domain;
      forceSSL = true;
      enableACME = true;
      addHostsEntries = true;
    };

    sonarr = {
      enable = true;
      openFirewall = true;
      config = {
        apiKey._secret = config.age.secrets.nixflix-sonarr-api-key.path;
        hostConfig.password._secret = config.age.secrets.nixflix-sonarr-password.path;
        hostConfig.bindAddress = "0.0.0.0";
      };
    };

    radarr = {
      enable = true;
      openFirewall = true;
      config = {
        apiKey._secret = config.age.secrets.nixflix-radarr-api-key.path;
        hostConfig.password._secret = config.age.secrets.nixflix-radarr-password.path;
        hostConfig.bindAddress = "0.0.0.0";
      };
    };

    prowlarr = {
      enable = true;
      openFirewall = true;
      config = {
        apiKey._secret = config.age.secrets.nixflix-prowlarr-api-key.path;
        hostConfig.password._secret = config.age.secrets.nixflix-prowlarr-password.path;
        hostConfig.bindAddress = "0.0.0.0";
      };
    };

    recyclarr.enable = true;

    jellyfin = {
      enable = true;
      openFirewall = true;
      apiKey._secret = config.age.secrets.nixflix-jellyfin-api-key.path;

      network.localNetworkAddresses = [ ];
      network.enablePublishedServerUriByRequest = true;

      users.admin = {
        policy.isAdministrator = true;
        password._secret = config.age.secrets.nixflix-jellyfin-admin-password.path;
      };

      system.pluginRepositories = {
        IAmParadox = {
          url = "https://www.iamparadox.dev/jellyfin/plugins/manifest.json";
          hash = "sha256-93n3Ehh6hWts8ONd6Dp/GYZd0g1Wb2lbHz4Kn6fhrwg=";
        };
        SeerrFin = {
          url = "https://raw.githubusercontent.com/varunaditya-plus/SeerrFin/main/manifest.json";
          hash = "sha256-NtPAR35Q9t5b4MVZfIZSEmtjDQnJbwE49pyLFJ9VVXI=";
        };
      };

      plugins = {
        "File Transformation" = {
          enable = true;
          package = inputs.nixflix.lib.jellyfinPlugins.fromRepo {
            version = "3.0.0.0";
            hash = "sha256-R3CU913Hfy1a88pZw+Qtdw+AP+u6BJmYzdH2/eFQbnw=";
            repository = "IAmParadox";
          };
        };

        SeerrFin = {
          enable = true;
          package = inputs.nixflix.lib.jellyfinPlugins.fromRepo {
            version = "1.8.3.1";
            hash = "sha256-q32T52pDyu0VnXN2QqsM21twfmUsEDN2hg0Emh600f8=";
            repository = "SeerrFin";
          };
          config = {
            JellyseerrUrl = "http://127.0.0.1:5055";
            ExternalJellyseerrUrl = "https://seerr.${domain}";
            JellyseerrApiKey._secret = config.age.secrets.nixflix-seerr-api-key.path;
          };
        };

        "Subtitle Extract" = {
          enable = true;
          config.ExtractionDuringLibraryScan = true;
        };
      };
    };

    seerr = {
      enable = true;
      openFirewall = true;
      apiKey._secret = config.age.secrets.nixflix-seerr-api-key.path;
    };

    torrentClients.qbittorrent = {
      enable = true;
      subdomain = "torrent";
      password._secret = config.age.secrets.nixflix-qbittorrent-password.path;
      serverConfig = {
        LegalNotice.Accepted = true;
        BitTorrent.Session.Port = 6881;
        Preferences.WebUI.Address = "*";
        Preferences.WebUI.Username = "admin";
        Preferences.WebUI.Password_PBKDF2 = "@ByteArray(e2hJ3Uz+kVA4f4dRajtXmQ==:KwMQW9U+eF6drlm1ZsfHWylDQncFaqcSZk9bPTamT208NQj3aJrV3+JU5quyKIczylNXpKFoyyVQ2IQ6akUHHA==)";
      };
    };
  };

  systemd.services.seerr.environment.HOST = lib.mkForce "0.0.0.0";

  security.acme.certs.${domain} = {
    domain = "*.${domain}";
    dnsProvider = "duckdns";
    credentialFiles.DUCKDNS_TOKEN_FILE = config.age.secrets.duckdnsToken.path;
    group = "nginx";
  };

  users.users.nginx.extraGroups = [ "media" ];

  services.nginx.virtualHosts =
    lib.genAttrs (map (subdomain: "${subdomain}.${domain}") restrictedSubdomains)
      (_: {
        extraConfig = lanOnly;
      });
}
