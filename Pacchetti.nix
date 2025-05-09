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
    nixpkgs-fmt
    nixfmt-rfc-style
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
    vscode
    vulkan-extension-layer
    vulkan-loader
    vulkan-tools
    vulkan-validation-layers
    wget
    wine64
    wine64Packages.waylandFull
    winetricks
  ];

  # Pacchetti liberi / Flake
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
