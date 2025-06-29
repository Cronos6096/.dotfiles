{ pkgs, inputs, self, ... }:

{
  environment.systemPackages = with pkgs; [
    cabextract
    unzip

    fzf
    tldr
    wget
    git
    ncdu

    # Neovim
    self.packages.${pkgs.system}.default

    bleachbit
    pciutils
    home-manager

    desktop-file-utils
    appimage-run
    kdePackages.kdeconnect-kde

    # dolphin
    kdePackages.breeze-icons
    kdePackages.dolphin
    kdePackages.kio
    kdePackages.kio-extras
    kdePackages.kservice
    kdePackages.qtsvg
    shared-mime-info
    hyprpolkitagent
    kdePackages.plasma-workspace

    # GPU
    mesa
    nvtopPackages.nvidia
    vulkan-loader
    vulkan-tools
    vulkan-extension-layer
    vulkan-validation-layers

    libva
    libva-utils

    # Strumenti
    libreoffice
    qalculate-gtk
    rpi-imager

    # Giochi
    # nexusmods-app-unfree
    prismlauncher
    wineWowPackages.full
    winetricks

    nvd
    orca-slicer # Slicer
    impression # Iso
  ];

  # Pacchetti liberi / Flake
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  # Manager partizioni
  programs.partition-manager.enable = true;
}
