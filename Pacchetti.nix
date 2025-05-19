{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    appimage-run
    bleachbit
    cabextract
    desktop-file-utils
    fzf
    git
    home-manager
    impression
    libreoffice
    libva
    libva-utils
    lm_sensors
    logitech-udev-rules
    mesa
    nexusmods-app-unfree
    nvd
    nvtopPackages.nvidia
    orca-slicer
    pciutils
    prismlauncher
    qalculate-gtk
    rpi-imager
    scrcpy
    tldr
    unzip
    vulkan-extension-layer
    vulkan-loader
    vulkan-tools
    vulkan-validation-layers
    wget
    wineWowPackages.full
    winetricks
  ];

  # Pacchetti liberi / Flake
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
