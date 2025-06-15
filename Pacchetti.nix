{ pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    cabextract
    unzip

    fzf
    tldr
    wget
    git
    ncdu

    nixd
    nixfmt-rfc-style
    statix
    #---#
    lua-language-server
    lua

    bleachbit
    pciutils
    home-manager

    desktop-file-utils
    appimage-run
    kdePackages.kdeconnect-kde

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
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}"];
}
