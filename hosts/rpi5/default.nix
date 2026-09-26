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
  ];

  networking = {
    hostName = "rpi5";
    wireless.enable = false;
    useNetworkd = true;

    firewall = {
      allowedUDPPorts = [
        5353
        8080
        8123
        8443
        25565
      ];
      allowedTCPPorts = [
        5353
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
    "99-ethernet-default-dhcp".networkConfig.MulticastDNS = "yes";
    "99-wireless-client-dhcp".networkConfig.MulticastDNS = "yes";
  };

  time.timeZone = "Europe/Rome";

  services.getty.autologinUser = "andme";

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";

  system.stateVersion = "25.11";

  system.nixos.tags = [
    "raspberry-pi-5"
    "generic-extlinux-compatible"
    config.boot.kernelPackages.kernel.version
  ];

  nix.settings.sandbox = true;

  services.openssh.enable = true;

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  users.users.andme.extraGroups = [
    "video"
  ];
}
