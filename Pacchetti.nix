{
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    # Strumenti da linea di comando
    any-nix-shell
    fzf
    git
    links2
    ncdu
    dysk
    opencode
    tealdeer
    wget
    ripgrep
    ripgrep-all

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
    home-manager

    # Integrazione desktop
    kdePackages.kdeconnect-kde

    # File manager e KDE
    kdePackages.breeze-icons
    kdePackages.dolphin
    kdePackages.kio
    kdePackages.kio-extras
    kdePackages.kservice
    kdePackages.qtsvg
    shared-mime-info
    kdePackages.ark
    kdePackages.filelight

    # Grafica e GPU
    mesa
    mesa_i686
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
    # kicad
    # kikit
    # kicadAddons.kikit
    # kicadAddons.kikit-library

    # Giochi e compatibilità Windows
    wineWow64Packages.full
    winetricks
    umu-launcher
    protonup-qt
    protontricks

    # Per fusion 360
    yad
    gawk
    mokutil
    samba
    bc
    lsb-release

    # Progetti e utilità varie
  ];

  # Manager partizioni
  programs.partition-manager.enable = true;
}
