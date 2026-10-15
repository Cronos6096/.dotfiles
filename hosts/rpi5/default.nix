{
  config,
  lib,
  ...
}:
{
  imports = [
    ./base.nix
    ./firmware.nix
    ./disko.nix
    ./services.nix
    ./nixflix.nix
  ];

  networking = {
    hostName = "rpi5";
    wireless.enable = false;
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
    "99-wireless-client-dhcp" = {
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

  services.getty.autologinUser = "andme";

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";

  system.stateVersion = "25.11";

  system.nixos.tags =
    let
      cfg = config.boot.loader.raspberry-pi;
    in
    [
      "raspberry-pi-${cfg.variant}"
      cfg.bootloader
      config.boot.kernelPackages.kernel.version
    ];

  nix.settings.sandbox = true;

  services.openssh.enable = true;

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  users.users.andme = {
    extraGroups = [
      "video"
    ];

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE0eWmYUr3u6FFhpv5Zj6LlcQIm8O4ZSJiZkuOtVM9NL andme@GiovanGianFranco"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE/06jWRdLOoCwgUk5SpMubBitLY4TMHZNvmushyv/30 andme@rpi5"
    ];
  };

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE0eWmYUr3u6FFhpv5Zj6LlcQIm8O4ZSJiZkuOtVM9NL andme@GiovanGianFranco"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE/06jWRdLOoCwgUk5SpMubBitLY4TMHZNvmushyv/30 andme@rpi5"
  ];
}
