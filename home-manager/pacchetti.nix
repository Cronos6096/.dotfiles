{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Roba
    ckan # Kerbal Space Program mod manager
    fastfetch
    lutris # Launcher
    obsidian # note taking app
    logseq # Note
    whatsie # Whatsapp
    yazi # terminal file manager
    kdePackages.kate # Notepad
    pinta # Paint.net (circa)
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
    p7zip
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
    kdePackages.plasma-workspace    # <- Provides plasma-applications.menu
    hyprpolkitagent

    # font
    cascadia-code
    jetbrains-mono
    nerd-fonts.zed-mono
    liberation_ttf
    times-newer-roman
    icu77

    # utilities
    appimage-run # AppImage runner
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
    inkscape
    obs-studio
    vlc # Media player

    # networking tools
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    dnsutils # `dig` + `nslookup`
    nmap # A utility for network discovery and security auditing

    # Terminale
    cava # Audio visualizer
    cmatrix
    cmake
    cowsay
    fd
    file
    lazygit
    gawk
    gitui
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

    # Strumenti
    btop # replacement of htop/nmon
    glow # markdown previewer in terminal
  ];
}
