{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./gpu.nix
    ./audio.nix
    moduli/Vm.nix
    moduli/Hyprland.nix
    moduli/Ollama.nix
    moduli/Solaar.nix
    moduli/Stylix.nix
    moduli/Python.nix
    moduli/Servizi.nix
  ];

  # Update automatici
  system.autoUpgrade.enable = true;
  system.autoUpgrade.dates = "weekly";

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  nix.settings.substituters = [ "https://nix-community.cachix.org" ];

  nix.settings.trusted-public-keys = [
    "nix-community.cachix.org-3:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
  ];

  # Swap
  swapDevices = [{
    device = "/swapfile";
    size = 30 * 1024; # 30GB
  }];

  # Hostname
  networking.hostName = "GiovanGianFranco";

  # Enable networking
  networking.networkmanager.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Set your time zone.
  time.timeZone = "Europe/Rome";

  # Stylix
  stylix.enable = true;

  # Ly
  services.displayManager.ly.enable = true;

  # Lingua
  console.keyMap = "it";
  services.xserver.xkb.layout = "it";

  i18n.defaultLocale = "it_IT.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "it_IT.UTF-8";
    LC_IDENTIFICATION = "it_IT.UTF-8";
    LC_MEASUREMENT = "it_IT.UTF-8";
    LC_MONETARY = "it_IT.UTF-8";
    LC_NAME = "it_IT.UTF-8";
    LC_NUMERIC = "it_IT.UTF-8";
    LC_PAPER = "it_IT.UTF-8";
    LC_TELEPHONE = "it_IT.UTF-8";
    LC_TIME = "it_IT.UTF-8";
  };

  # Account
  users.users.andme = {
    isNormalUser = true;
    description = "Andrei Merciaro";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    shell = pkgs.zsh;
    home = "/home/andme";
  };

  users.groups.gcis = { };
  users.users.gcis = {
    isSystemUser = true;
    group = "gcis";
  };

  # zsh shell
  programs.zsh.enable = true;

  # Abilita pacchetti unfree/Flake
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [
    anydesk
    appimage-run
    clamtk
    floorp
    fzf
    git
    home-manager
    hyprpanel
    libreoffice
    libva
    libva-utils
    logitech-udev-rules
    mangohud
    mesa
    nil
    nix-output-monitor
    nixfmt-classic
    nvd
    nvtopPackages.nvidia
    prismlauncher
    qalculate-gtk
    tldr
    vscode
    vulkan-extension-layer
    vulkan-loader
    vulkan-tools
    vulkan-validation-layers
    wget
    winetricks
    wineWowPackages.waylandFull
  ];

  # Steam
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;

  system.stateVersion = "25.05";

}
