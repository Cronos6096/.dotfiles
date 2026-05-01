{ pkgs, ... }:
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

    # Codice
    typst
    typst-live
    typstyle
    nixd
    nixfmt
    github-cli
    opencode
    claude-code
    lazyssh
    lazygit
    lazyjournal

    # Produttività e documenti
    # libreoffice-qt
    # hunspell
    # hunspellDicts.it_IT
    zathura
    qalculate-gtk
    kicad

    # Video / Audio
    vlc
    # blender
    # davinci-resolve
    # krita
    # gimp3

    # Network
    aria2
    dnsutils
    nmap

    # Terminale
    pinentry-all
    btop-cuda
    caligula
  ];

  programs.vesktop.enable = true;
}
