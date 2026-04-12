{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./pi5-configtxt.nix
    ./disko-btrfs.nix
    ./server.nix
    ./options.nix
  ];

  networking.hostName = "rpi5";
  time.timeZone = "Europe/Rome";

  users.users.andme = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
    ];
    shell = pkgs.fish;
    hashedPasswordFile = config.age.secrets.password.path;
  };

  programs.fish.enable = true;

  nix.settings.trusted-users = [ "andme" ];

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "yes";
    };
  };

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  services.getty.autologinUser = "andme";

  networking = {
    wireless.enable = false;
    useNetworkd = true;
    firewall = {
      allowedUDPPorts = [
        5353
        9000
        8080
        8123
        8443
      ];
      allowedTCPPorts = [
        5353
        9000
        8080
        8123
        8443
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

  system.stateVersion = config.system.nixos.release;

  system.nixos.tags =
    let
      cfg = config.boot.loader.raspberry-pi;
    in
    [
      "raspberry-pi-${cfg.variant}"
      cfg.bootloader
      config.boot.kernelPackages.kernel.version
    ];
  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
