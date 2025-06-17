{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Roba
    ckan # Kerbal Space Program mod manager
    fastfetch
    lutris # Launcher
    obsidian # Note
    whatsie # Whatsapp
    yazi # terminal file manager
    kdePackages.kate # Notepad
    zed-editor-fhs # Ide

    # Hyprland
    dunst
    wofi
    wl-clipboard
    clipse
    hyprshot
    pavucontrol
    networkmanager
    handlr
    hyprsome
    hyprpaper

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
    flatpak
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
    gimp # Image editor
    vlc # Media player

    # Network
    aria2
    dnsutils
    nmap

    # Terminale
    cava # Audio visualizer
    cmatrix
    cmake
    cowsay
    fd
    file
    lazygit
    gnupg
    gnused
    pinentry-all
    gnutar
    hollywood
    ripgrep
    tree
    undollar
    which
    zstd
    btop
  ];
}
