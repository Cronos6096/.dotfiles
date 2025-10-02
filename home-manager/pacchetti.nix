{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Roba
    ckan # Kerbal Space Program mod manager
    fastfetch
    lutris # Launcher
    obsidian # Note
    yazi # terminal file manager
    kdePackages.kate # Notepad
    zed-editor # Ide
    kdePackages.kget
    gimp3

    # archivi
    unp
    unrar
    unzip
    xz
    zip

    # font
    liberation_ttf
    times-newer-roman
    icu77
    jetbrains-mono

    # libreoffice
    libreoffice-qt
    hunspell
    hunspellDicts.it_IT

    # utilities
    kdePackages.ark # File archiver
    bat # cat migliorato
    eza # ls migliorato
    fzf
    qbittorrent-enhanced
    ripgrep
    udiskie # Automontatore
    vesktop # Discord
    pandoc
    cmake
    pyright
    rustdesk

    # Video / Audio
    blender
    # davinci-resolve # Video editor
    vlc # Media player
    kdePackages.okular # Pdf
    krita # Image editor

    # Network
    aria2
    dnsutils
    nmap

    # Terminale
    cava # Audio visualizer
    cmatrix
    cowsay
    fd
    file
    lazygit
    gnupg
    gnused
    pinentry-all
    gnutar
    undollar
    which
    zstd
    btop
    caligula
  ];
}
