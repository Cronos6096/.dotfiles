{
  pkgs,
  inputs,
  self,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    # Archivi
    cabextract
    unzip
    p7zip

    # Strumenti da linea di comando
    any-nix-shell
    fzf
    git
    links2
    ncdu
    opencode
    tldr
    wget

    # Codice
    typst
    typst-live
    typstyle
    nixd
    nixfmt
    github-cli
    lmstudio

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
    # kdePackages.plasma-workspace

    # Grafica e GPU
    mesa
    mesa_i686
    nvtopPackages.nvidia
    vulkan-loader
    vulkan-tools
    vulkan-extension-layer
    vulkan-validation-layers
    libva
    libva-utils
    egl-wayland
    libglvnd
    wayland
    wayland-protocols
    mangohud
    dxvk

    # Produttività e documenti
    libreoffice-qt
    hunspell
    hunspellDicts.it_IT
    zathura

    qalculate-gtk
    kicad
    kikit
    kicadAddons.kikit
    kicadAddons.kikit-library

    # Strumenti Raspberry Pi
    rpi-imager

    # Giochi e compatibilità Windows
    prismlauncher
    wineWowPackages.full
    winetricks
    umu-launcher
    protonup-qt
    protontricks

    yad
    gawk
    mokutil
    samba
    bc
    lsb-release

    # Progetti e utilità varie
    nvd
    orca-slicer # Slicer 3D
  ];

  # Manager partizioni
  programs.partition-manager.enable = true;
}
