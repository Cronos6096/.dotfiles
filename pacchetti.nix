{pkgs, ...}: {
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

    # font
    cascadia-code
    jetbrains-mono
    nerd-fonts.zed-mono

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

    # Video / Audio
    blender
    davinci-resolve # Video editor
    flameshot # Screenshot
    gimp # Image editor
    inkscape
    obs-studio
    vlc # Media player

    # networking tools
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    dnsutils # `dig` + `nslookup`
    ipcalc # it is a calculator for the IPv4/v6 addresses
    iperf3
    ldns # replacement of `dig`, it provide the command `drill`
    mtr # A network diagnostic tool
    nmap # A utility for network discovery and security auditing
    socat # replacement of openbsd-netcat

    # Terminale
    cava # Audio visualizer
    cmatrix
    cowsay
    fd
    file
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
    lunarvim # Neovim

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
