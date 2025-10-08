{ pkgs, inputs, self, ... }:

{
  environment.systemPackages = with pkgs; [
    # Archivi
    cabextract
    unzip
    p7zip

    # Strumenti da linea di comando
    fzf
    tldr
    wget
    git
    ncdu

    # Editor e strumenti di sviluppo
    self.packages.${pkgs.system}.default   # Neovim

    # Amministrazione di sistema
    bleachbit
    pciutils
    home-manager

    # Integrazione desktop
    desktop-file-utils
    appimage-run
    kdePackages.kdeconnect-kde

    # File manager e KDE
    kdePackages.breeze-icons
    kdePackages.dolphin
    kdePackages.kio
    kdePackages.kio-extras
    kdePackages.kservice
    kdePackages.qtsvg
    shared-mime-info
    hyprpolkitagent
    kdePackages.plasma-workspace

    # Grafica e GPU
    mesa
    nvtopPackages.nvidia
    vulkan-loader
    vulkan-tools
    vulkan-extension-layer
    vulkan-validation-layers
    libva
    libva-utils

    # Produttività e documenti
    libreoffice-qt
    hunspell
    hunspellDicts.it_IT

    qalculate-gtk
    kicad

    # Strumenti Raspberry Pi
    rpi-imager

    # Giochi e compatibilità Windows
    prismlauncher
    wineWowPackages.full
    winetricks
    protonup-qt
    protontricks
    inputs.nix-citizen.packages.${system}.star-citizen

    # Progetti e utilità varie
    nvd
    orca-slicer    # Slicer 3D
    impression     # Creazione ISO
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
