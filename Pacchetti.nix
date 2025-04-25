{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    appimage-run
    cabextract
    clamtk
    floorp
    fzf
    git
    home-manager
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
    xorg.libxcb
    xorg.libXcursor
  ];

  # Pacchetti liberi / Flake
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
