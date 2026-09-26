{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    home-manager

    # Grafica e GPU
    dxvk
    egl-wayland
    libglvnd
    libva
    libva-utils
    mangohud
    mesa
    mesa_i686
    protontricks
    protonup-qt
    umu-launcher
    vulkan-extension-layer
    vulkan-loader
    vulkan-tools
    vulkan-validation-layers
    wayland
    wayland-protocols
    wineWow64Packages.full
    winetricks
  ];

  # Manager partizioni
  programs.partition-manager.enable = true;
}
