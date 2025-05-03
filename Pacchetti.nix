{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    appimage-run
    bitwarden-desktop
    cabextract
    clamtk
    floorp
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
    nix-output-monitor
    nixd
    nixfmt-rfc-style
    nvd
    nvtopPackages.nvidia
    orca-slicer
    pciutils
    prismlauncher
    qalculate-gtk
    rpi-imager
    tldr
    unzip
    vscode
    vulkan-extension-layer
    vulkan-loader
    vulkan-tools
    vulkan-validation-layers
    wget
    wine
    wineWowPackages.stable
    wineWowPackages.full
    wineWowPackages.waylandFull
    winetricks
    xorg.libXcursor
    mokutil
    xorg.libxcb
  ];

  # Pacchetti liberi / Flake
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
