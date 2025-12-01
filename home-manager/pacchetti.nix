{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Roba
    ckan # Kerbal Space Program mod manager
    fastfetch
    lutris # Launcher
    yazi # terminal file manager
    kdePackages.kate # Notepad
    zed-editor
    gimp3
    whatsapp-electron

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
