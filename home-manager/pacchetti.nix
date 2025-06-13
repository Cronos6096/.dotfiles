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
    zed-editor # Ide

    # Hyprland
    dunst
    hyprpaper
    wofi
    wl-clipboard
    clipse
    hyprshot
    pavucontrol
    networkmanager
    handlr
    hyprsome

    # archivi
    unp
    unrar
    unzip
    xz
    zip

    # dolphin
    kdePackages.breeze-icons
    kdePackages.dolphin
    kdePackages.kio
    kdePackages.kio-extras
    kdePackages.kservice
    kdePackages.qtsvg
    shared-mime-info
    kdePackages.plasma-workspace
    hyprpolkitagent

    # font
    cascadia-code
    jetbrains-mono
    nerd-fonts.zed-mono
    liberation_ttf
    times-newer-roman
    icu77

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
    wiki-tui
    gnupg
    gnused
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
