{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./gpu.nix
    ./audio.nix
    ../moduli/system
    ../Pacchetti.nix
    ../Pacchetti-NUR.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  system.autoUpgrade = {
    enable = true;
    dates = "16:00";
    randomizedDelaySec = "15min";
  };

  # Swap
  boot.kernel.sysctl = {
    "vm.max_map_count" = 16777216;
    "fs.file-max" = 524288;
  };
  swapDevices = [
    {
      device = "/swapfile";
      size = 32 * 1024;
    }
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
  users.users.andme = {
    isNormalUser = true;
    description = "Andrei Merciaro";
    extraGroups = [
      "networkmanager"
      "wheel"
      "libvirtd"
    ];
    shell = pkgs.zsh;
    home = "/home/andme";
  };

  users.groups.gcis = { };
  users.users.gcis = {
    isSystemUser = true;
    group = "gcis";
  };

  environment.etc."/xdg/menus/applications.menu".text =
    builtins.readFile "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";

  # zsh shell
  programs.zsh.enable = true;

  # Nix-shell
  nixpkgs.config = {
    stdenv = {
      shell = pkgs.nushell;
    };
  };

  system.stateVersion = "25.11";
}
