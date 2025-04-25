{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./gpu.nix
    ./audio.nix
    ../moduli
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  system.autoUpgrade = {
    enable = true;
    dates = "16:00";
    randomizedDelaySec = "45min";
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

  # Tracking batteria
  services.upower.enable = true;
  services.blueman.enable = true;
  services.libinput.enable = true;
  services.power-profiles-daemon.enable = true;

  programs.hyprland.enable = true;
  # programs.hyprland.package = inputs.hyprland.packages."${pkgs.system}".hyprland;
  
  # Stylix
  stylix.enable = true;

  # Ly
  services.displayManager.ly.enable = true;

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

  # zsh shell
  programs.zsh.enable = true;

  # Abilita pacchetti unfree/Flake
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  environment.systemPackages = with pkgs; [
    appimage-run
    cabextract
    clamtk
    floorp
    fzf
    git
    home-manager
    libreoffice
    libva
    libva-utils
    logitech-udev-rules
    mesa
    nil
    nix-output-monitor
    nixfmt-rfc-style
    nvd
    nvtopPackages.nvidia
    orca-slicer
    prismlauncher
    qalculate-gtk
    tldr
    unzip
    vscode
    vulkan-extension-layer
    vulkan-loader
    vulkan-tools
    vulkan-validation-layers
    wget
    wine
    winetricks
    wineWowPackages.full
    wineWowPackages.waylandFull
  ];

  system.stateVersion = "25.05";
}
