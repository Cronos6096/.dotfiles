{ pkgs, ... }:

{
  imports =
    [ ./programs/Terminale.nix ./programs/Hyprland.nix ];

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.username = "andme";
  home.homeDirectory = "/home/andme";

  home.sessionVariables = {
    EDITOR = "lvim";
    VISUAL = "lvim";
    BROWSER = "floorp";
    # TERMINAL = "ghostty";
    TERMINAL = "kitty";
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [

    # Roba
    fastfetch
    yazi # terminal file manager
    lutris # Launcher
    ckan # Kerbal Space Program mod manager

    # archives
    zip
    xz
    unzip
    p7zip

    # fonts
    jetbrains-mono
    cascadia-code
    nerd-fonts.zed-mono

    # utilities
    ripgrep # recursively searches directories for a regex pattern
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder
    bat # A cat clone with wings
    vesktop # Discord
    qbittorrent-enhanced # Torrent client
    appimage-run # AppImage runner

    # Video / Audio
    davinci-resolve # Video editor
    obs-studio # Screen recorder
    flameshot # Screenshot tool
    gimp # Image editor
    inkscape # Vector graphics editor
    blender # 3D creation suite
    vlc # Media player

    # networking tools
    mtr # A network diagnostic tool
    iperf3
    dnsutils # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc # it is a calculator for the IPv4/v6 addresses

    # Terminale
    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg
    cmatrix
    hollywood
    cava # Audio visualizer

    # Strumenti
    glow # markdown previewer in terminal
    btop # replacement of htop/nmon
    lunarvim # Neovim

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
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
