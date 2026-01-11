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
    initialHashedPassword = "";
  };

  users.groups.andme = { };

  users.users.root.initialHashedPassword = "";

  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "yes";
  };

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  services.getty.autologinUser = "andme";

  networking = {
    useNetworkd = true;
    firewall = {
      allowedUDPPorts = [
        5353
        9000
        8123
        8443
      ];
      allowedTCPPorts = [
        5353
        9000
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

  # networking.wireless.enable = false;
  # networking.wireless.iwd = {
  #   enable = true;
  #   settings = {
  #     Network = {
  #       EnableIPv6 = true;
  #       RoutePriorityOffset = 300;
  #     };
  #     Settings.AutoConnect = true;
  #   };
  # };

  environment.systemPackages = with pkgs; [
    git
    btop
    lazydocker
  ];

  nix.settings.trusted-users = [ "andme" ];

  system.stateVersion = config.system.nixos.release;

  system.nixos.tags =
    let
      cfg = config.boot.loader.raspberryPi;
    in
    [
      "raspberry-pi-${cfg.variant}"
      cfg.bootloader
      config.boot.kernelPackages.kernel.version
    ];
}
