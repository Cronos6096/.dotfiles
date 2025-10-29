{ pkgs, config, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./gpu.nix
    ./audio.nix
    ../../moduli/system
    ../../Pacchetti.nix
    ../../Pacchetti-NUR.nix
  ];

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_cachyos;

  boot.loader = {
    systemd-boot = {
      enable = false;
    };
    efi.canTouchEfiVariables = true;
    limine = {
      enable = true;
      secureBoot.enable = true;
    };
  };
  environment.systemPackages = [
    pkgs.sbctl
  ];

  # Swap
  swapDevices = [
    {
      device = "/swapfile";
      size = 32 * 1024;
    }
  ];

  boot.kernel.sysctl = {
    "vm.max_map_count" = 16777216;
    "fs.file-max" = 524288;
  };

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
  sops.secrets.passwordAndme.neededForUsers = true;
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
      hashedPasswordFile = config.sops.secrets.passwordAndme.path;
    };

    groups.gcis = { };
    users.gcis = {
      isSystemUser = true;
      group = "gcis";
    };
  };

  environment.etc."/xdg/menus/applications.menu".text =
    builtins.readFile "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";

  # Fish shell
  programs.fish.enable = true;

  system.stateVersion = "25.11";
}
