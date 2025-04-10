{ pkgs, ... }:
{
  # Pacchetti utente
  home.packages = with pkgs; [
    # Roba
    ckan # Kerbal Space Program mod manager
    fastfetch
    lutris # Launcher
    obsidian # note taking app
    whatsapp-for-linux # Whatsapp
    yazi # terminal file manager
    kdePackages.kate # editor di testo

    # Hyprland
    dunst
    hyprpaper
    wofi
    wl-clipboard
    clipse
    hyprshot

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
    hyprpolkitagent

    # font
    cascadia-code
    jetbrains-mono
    nerd-fonts.zed-mono
    liberation_ttf
    times-newer-roman

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

    # Video / Audio
    blender
    davinci-resolve # Video editor
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

    # system call monitoring
    lsof # list open files
    ltrace # library call monitoring
    strace # system call monitoring

    # system tools
    ethtool
    lm_sensors # for `sensors` command
    pciutils # lspci
    sysstat
    usbutils # lsusb
  ];
}
