{ pkgs, ... }:

{
  imports = [ programs/Terminale.nix programs/Stylix ];

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.username = "andme";
  home.homeDirectory = "/home/andme";

  home.sessionVariables = {
    EDITOR = "lvim";
    VISUAL = "lvim";
    BROWSER = "floorp";
    TERMINAL = "ghostty";
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [

    # Roba
    ckan # Kerbal Space Program mod manager
    fastfetch
    kdePackages.dolphin # File manager
    lutris # Launcher
    protonvpn-gui # VPN
    yazi # terminal file manager
    
    # Hyprland
    wofi
    waybar
    hyprpaper
    waytrogen
    pavucontrol

    # archives
    p7zip
    unzip
    xz
    zip

    # fonts
    cascadia-code
    jetbrains-mono
    nerd-fonts.zed-mono

    # utilities
    appimage-run # AppImage runner
    bat # A cat clone with wings
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder
    qbittorrent-enhanced # Torrent client
    ripgrep # recursively searches directories for a regex pattern
    vesktop # Discord

    # Video / Audio
    blender # 3D creation suite
    davinci-resolve # Video editor
    flameshot # Screenshot tool
    gimp # Image editor
    inkscape # Vector graphics editor
    obs-studio # Screen recorder
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

  # basic configuration of git
  programs.git = {
    enable = true;
    userName = "Cronos6096";
    userEmail = "and.merciaro@gmail.com";
    extraConfig = {
      init.defaultBranch = "master";
      safe.directory = "/home/andme/.dotfiles";
    };
  };

  home.stateVersion = "25.05";
}
