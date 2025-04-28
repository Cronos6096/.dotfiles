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
    logitech-udev-rules
    mesa
    nix-output-monitor
    nixd
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
    wineWowPackages.full
    wineWowPackages.waylandFull
    winetricks
    xorg.libXcursor
    xorg.libxcb
  ];

  # Pacchetti liberi / Flake
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
