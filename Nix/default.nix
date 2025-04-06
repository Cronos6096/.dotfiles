{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./gpu.nix
    ./audio.nix
    moduli/Hyprland.nix
    moduli/Lingua.nix
    moduli/Ollama.nix
    moduli/Python.nix
    moduli/Rust.nix
    moduli/Servizi.nix
    moduli/Solaar.nix
    moduli/Stylix.nix
    moduli/Vm.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

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

  zramSwap.enable = true;

  # Hostname
  networking.hostName = "GiovanGianFranco";

  # Rete
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

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
    anydesk
    appimage-run
    cabextract
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

  services.emacs.package = pkgs.emacs-unstable;
  services.emacs.enable = true;
  nixpkgs.overlays = [
    (import (
      builtins.fetchTarball {
        url = "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
        sha256 = "1x2q47bzw2j97c6xvxixzp2skyavivm928wl7p83z9scdwcf7ryr";
      }
    ))
  ];

  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;

  system.stateVersion = "25.05";
}
