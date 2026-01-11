{
  pkgs,
  config,
  inputs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./gpu.nix
    ./audio.nix
    ../../moduli/system
    ../../Pacchetti.nix
  ];

  # Hostname
  networking.hostName = "GiovanGianFranco";

  # Rete
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Hyprland
  programs.hyprland.enable = true;

  # Stylix
  stylix.enable = true;

  # Account
  users.mutableUsers = false;

  users = {
    users.andme = {
      isNormalUser = true;
      extraGroups = [
        "networkmanager"
        "wheel"
        "libvirtd"
        "dialout"
        "kvm"
      ];
      shell = pkgs.fish;
      home = "/home/andme";
      hashedPasswordFile = config.age.secrets.password.path;
    };

    groups.gcis = { };
    users.gcis = {
      isSystemUser = true;
      group = "gcis";
    };
  };

  # Fish shell
  programs.fish.enable = true;

  # Fix logrotate configuration
  services.logrotate.enable = false;

  system.stateVersion = "25.11";
}
