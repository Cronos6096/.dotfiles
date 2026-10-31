{
  config,
  inputs,
  lib,
  pkgs,
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
          hash = "sha256-Idybc1kQxm/85FBVfh2zicR6cmzdattDJTw2mnCgmUs=";
        };
        SeerrFin = {
          url = "https://raw.githubusercontent.com/varunaditya-plus/SeerrFin/main/manifest.json";
          hash = "sha256-qkDHkyJ6nFw+mQXS9yGsruHXcIhPbFJaCRWyCRSD+A8=";
        };
        IntroSkipper = {
          # intro-skipper.org/manifest.json redirects to an HTML page; real
          # Jellyfin-12 manifest lives in the dedicated manifest repo.
          url = "https://raw.githubusercontent.com/intro-skipper/manifest/main/12/manifest.json";
          hash = "sha256-OE2mDp8H9ZzZ7hnUpCdO0s1k9r0gPRAIPBGuy4UaH3U=";
        };
      };

      plugins = {
        "File Transformation" = {
          enable = true;
          # The IAmParadox manifest ships one release per targetAbi (10.11.x,
          # 12.0.0, ..., 12.4.0) for every version, and every build targets a
          # Jellyfin <= 12.4, so `fromRepo` always resolves more than one match
          # and throws "matched multiple releases". Pin the archive for the
          # 12.4 ABI directly instead of going through the resolver.
          package = pkgs.fetchzip {
            name = "jellyfin-plugin-file-transformation";
            url = "https://github.com/IAmParadox27/jellyfin-plugin-file-transformation/releases/download/3.0.3.0/Release-12.4.0.zip";
            hash = "sha256-L9GFSHvFZ3h4f6Lr6bYSwzen3fMZ/3ZHHhihF0a637E=";
            stripRoot = false;
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

        "Intro Skipper" = {
          package = inputs.nixflix.lib.jellyfinPlugins.fromRepo {
            version = "12.0.6.0";
            hash = "sha256-g8Oiyt4NK8pyCXt2M1B7EpEL71kUGGkxtXSzKndUuOQ=";
            repository = "IntroSkipper";
          };
          config = {
            ExcludeSeries = "";
            AutoDetectIntros = true;
            AnalyzeSeasonZero = false;
            PreferChromaprint = false;
            CacheFingerprints = true;
            UseAlternativeBlackFrameAnalyzer = false;
            UpdateMediaSegments = true;
            RebuildMediaSegments = true;
            ScanIntroduction = true;
            ScanCredits = true;
            ScanRecap = true;
            ScanPreview = true;
            ScanCommercial = false;
            AnalysisPercent = "25";
            AnalysisLengthLimit = "10";
            FullLengthChapters = false;
            SkipFirstEpisode = false;
            SkipFirstEpisodeAnime = false;
            MinimumIntroDuration = "15";
            MaximumIntroDuration = "120";
            MinimumCreditsDuration = "15";
            MaximumCreditsDuration = "450";
            MaximumMovieCreditsDuration = "900";
            MinimumRecapDuration = "15";
            MaximumRecapDuration = "120";
            MinimumPreviewDuration = "15";
            MaximumPreviewDuration = "120";
            MinimumCommercialDuration = "15";
            MaximumCommercialDuration = "120";
            BlackFrameMinimumPercentage = "85";
            BlackFrameThreshold = "28";
            UseChapterMarkersBlackFrame = true;
            AdjustIntroBasedOnChapters = true;
            AdjustIntroBasedOnSilence = true;
            SnapToKeyframe = true;
            EndSnapThreshold = "2";
            AdjustWindowInward = "5";
            AdjustWindowOutward = "2";
            ChapterAnalyzerIntroductionPattern = "(^|\\s)(Intro|Introduction|OP|Opening)(?!\\sEnd)(\\s|$)";
            ChapterAnalyzerEndCreditsPattern = "(^|\\s)(Credits?|ED|Ending|Outro)(?!\\sEnd)(\\s|$)";
            ChapterAnalyzerPreviewPattern = "(^|\\s)(Preview|PV|Sneak\\s?Peek|Coming\\s?(Up|Soon)|Next\\s+(time|on|episode)|Extra|Teaser|Trailer)(?!\\sEnd)(\\s|:|$)";
            ChapterAnalyzerRecapPattern = "(^|\\s)(Re?cap|Sum{1,2}ary|Prev(ious(ly)?)?|(Last|Earlier)(\\s\\w+)?|Catch[ -]up)(?!\\sEnd)(\\s|:|$)";
            ChapterAnalyzerCommercialPattern = "(^|\\s)(Ad(vert(isement)?)?|Commercial)(?!\\sEnd)(\\s|$)";
            IntroEndOffset = "0";
            IntroStartOffset = "0";
            MaximumFingerprintPointDifferences = 6;
            MaximumTimeSkip = 3.5;
            InvertedIndexShift = 2;
            SilenceDetectionMaximumNoise = "-50";
            SilenceDetectionMinimumDuration = "0.33";
            MaxParallelism = "2";
            ProcessThreads = "0";
            ProcessPriority = "BelowNormal";
            UseFileTransformationPlugin = false;
            SkipbuttonHideDelay = "8";
            EnableMainMenu = true;
            FileTransformationPluginEnabled = false;
          };
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
        Preferences.WebUI = {
          Address = "*";
          Username = "admin";
          Password_PBKDF2 = "@ByteArray(e2hJ3Uz+kVA4f4dRajtXmQ==:KwMQW9U+eF6drlm1ZsfHWylDQncFaqcSZk9bPTamT208NQj3aJrV3+JU5quyKIczylNXpKFoyyVQ2IQ6akUHHA==)";
        };
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
