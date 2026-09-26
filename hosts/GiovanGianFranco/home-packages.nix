{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    ckan
    lutris-free
    prismlauncher
    vesktop
    whatsapp-electron
    easyeffects

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
    kdePackages.kdeconnect-kde

    # font
    icu77
    liberation_ttf
    times-newer-roman

    # utilities
    bleachbit
    orca-slicer
    qbittorrent-enhanced
    yazi
    androidenv.androidPkgs.platform-tools

    # code
    github-cli
    lazygit
    mcp-nixos
    nixd
    nixfmt
    opencode
    typst
    typst-live
    typstyle

    # documets
    libreoffice-qt
    hunspell
    hunspellDicts.it_IT
    zathura
    qalculate-gtk
    kicad
    kicadAddons.kikit

    # Video / Audio
    vlc

    # Network
    aria2
    dnsutils
    nmap

    # Terminal
    btop-cuda
    caligula
  ];

  programs.vesktop.enable = true;
}
