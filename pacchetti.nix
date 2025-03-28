{pkgs, ...}:

{
  # Pacchetti utente
  home.packages = with pkgs; [

    # Roba
    ckan # Kerbal Space Program mod manager
    fastfetch
    lutris # Launcher
    yazi # terminal file manager
    whatsapp-for-linux # Whatsapp
    kdePackages.dolphin # File manager
    obsidian

    # Hyprland
    wofi
    hyprpaper
    dunst

    # archivi
    p7zip
    unzip
    xz
    zip
    unrar
    unp

    # font
    cascadia-code
    jetbrains-mono
    nerd-fonts.zed-mono

    # utilities
    appimage-run # AppImage runner
    bat # cat migliorato
    eza # ls migliorato
    fzf
    qbittorrent-enhanced
    ripgrep
    vesktop # Discord
    udiskie # Automontatore
    flatpak
    cachix

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
    file
    gawk
    gnupg
    gnused
    gnutar
    hollywood
    tree
    which
    zstd
    fd
    ripgrep
    undollar

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
