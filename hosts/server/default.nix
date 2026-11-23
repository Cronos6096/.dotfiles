{
  lib,
  ...
}:
{
  imports = [
    ./hardware.nix
    ./boot.nix
    ./disko.nix
    ./services.nix
    ./nixflix.nix
  ];

  networking = {
    hostName = "server";
    useNetworkd = true;

    firewall = {
      allowedUDPPorts = [
        5353
        6881
        8080
        8123
        8443
        25565
      ];
      allowedTCPPorts = [
        80
        443
        5353
        6881
        8282
        8080
        8123
        8443
        25565
      ];
      allowedTCPPortRanges = [
        {
          from = 25500;
          to = 25600;
        }
      ];
    };
  };

  systemd.network.networks = {
    "99-ethernet-default-dhcp" = {
      networkConfig = {
        MulticastDNS = "yes";
        DNS = [
          "9.9.9.9"
          "149.112.112.112"
          "2620:fe::fe"
          "2620:fe::9"
        ];
      };
      dhcpV4Config.UseDNS = false;
      dhcpV6Config.UseDNS = false;
    };
  };

  time.timeZone = "Europe/Rome";

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  system.stateVersion = "25.11";

  system.autoUpgrade = {
    enable = true;
    flake = "github:Cronos6096/.dotfiles#server";
    # `--upgrade` only updates channels, which this host does not use.
    upgrade = false;
    flags = [
      "--update-input"
      "nixpkgs"
    ];
    runGarbageCollection = true;
  };

  nix.settings.sandbox = true;

  services.openssh.enable = true;

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  users.users.andme = {
    extraGroups = [ "video" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE0eWmYUr3u6FFhpv5Zj6LlcQIm8O4ZSJiZkuOtVM9NL andme@GiovanGianFranco"
    ];
  };

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE0eWmYUr3u6FFhpv5Zj6LlcQIm8O4ZSJiZkuOtVM9NL andme@GiovanGianFranco"
  ];
}
