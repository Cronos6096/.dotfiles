{
  pkgs,
  ...
}:

let
  kicadLibs = pkgs.kicad.passthru.libraries;
  kicadTemplateDir = pkgs.symlinkJoin {
    name = "KiCad_template_dir";
    paths = with kicadLibs; [
      "${templates}/share/kicad/template"
      "${footprints}/share/kicad/template"
      "${symbols}/share/kicad/template"
    ];
  };

  kicadWithUpdatedEnv = pkgs.kicad.overrideAttrs (oldAttrs: {
    makeWrapperArgs = oldAttrs.makeWrapperArgs ++ [
      "--set-default KICAD10_SYMBOL_DIR ${kicadLibs.symbols}/share/kicad/symbols"
      "--set-default KICAD10_FOOTPRINT_DIR ${kicadLibs.footprints}/share/kicad/footprints"
      "--set-default KICAD10_3DMODEL_DIR ${kicadLibs.packages3d}/share/kicad/3dmodels"
      "--set-default KICAD10_TEMPLATE_DIR ${kicadTemplateDir}"
    ];
  });

in

{
  environment.systemPackages = with pkgs; [
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
    # libreoffice-qt
    # hunspell
    # hunspellDicts.it_IT
    zathura

    qalculate-gtk
    kicadWithUpdatedEnv

    # Giochi e compatibilità Windows
    wineWow64Packages.full
    winetricks
    umu-launcher
    protonup-qt
    protontricks
  ];

  # Manager partizioni
  programs.partition-manager.enable = true;
}
