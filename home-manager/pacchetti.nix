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
    rustdesk

    # Video / Audio
    vlc # Media player
    # blender
    # davinci-resolve # Video editor
    # krita # Image editor
    # gimp3

    # Network
    aria2
    dnsutils
    nmap

    # Terminale
    fd
    file
    lazygit
    gnupg
    gnused
    pinentry-all
    gnutar
    which
    zstd
    btop
    caligula
  ];
}
