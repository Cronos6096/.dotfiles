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
  ];

  networking.hostName = "rpi5";
  time.timeZone = "Europe/Rome";

  users.users.nixos = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
    ];
    initialHashedPassword = "";
  };

  users.users.andme = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
    ];
    initialHashedPassword = "";
    group = "andme";
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

  services.getty.autologinUser = "nixos";

  networking.useNetworkd = true;
  networking.firewall.allowedUDPPorts = [ 5353 ];
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
  ];

  nix.settings.trusted-users = [ "nixos" ];

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
