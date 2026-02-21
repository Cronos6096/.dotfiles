{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Roba
    ckan # Kerbal Space Program mod manager
    fastfetch
    lutris # Launcher
    yazi # terminal file manager
    kdePackages.kate # Notepad
    whatsapp-electron
    vesktop
    prismlauncher

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
    bat
    eza
    fzf
    qbittorrent-enhanced
    udiskie # Automontatore
    orca-slicer # Slicer 3D

    # Video / Audio
    vlc
    # blender
    # davinci-resolve
    krita
    # gimp3

    # Network
    aria2
    dnsutils
    nmap

    # Terminale
    lazygit
    pinentry-all
    which
    btop-cuda
    caligula
  ];
}
