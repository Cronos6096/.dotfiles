{ config, pkgs, inputs, ... }:

{

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.username = "andme";
  home.homeDirectory = "/home/andme";

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # Roba
    fastfetch
    yazi # terminal file manager
    # micro # terminal text editor

    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder
    bottles # Emulatore
    bat # A cat clone with wings
    discord # Chats

    # networking tools
    mtr # A network diagnostic tool
    iperf3
    dnsutils  # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc  # it is a calculator for the IPv4/v6 addresses

    # misc
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

    # productivity
    glow # markdown previewer in terminal
    btop  # replacement of htop/nmon

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

    # Nh
   programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/andme/.dotfiles/";
  };

  # Terminale
  programs.ghostty = {
    enable = true;
  };

  # zsh shell
  programs.zsh = {
    enable = true;
    enableCompletion = true;  # Enables auto completion.
    autosuggestion.enable = true;  # Enables autosuggestions.
    syntaxHighlighting.enable = true;  # Enables syntax highlighting.

    # Example aliases and history settings:
    shellAliases = {
      ls = "eza";
      ff = "fastfetch";
      search = "nix search nixpkgs";
      rebuild = "nh os switch . -H andme";
      cat = "bat";
      top = "btop";
      htop = "btop";
      cdconfig = "cd /home/andme/.dotfiles";
    };
    history.size = 10000;
  };

  # # bash shell
  # programs.bash = {
  #   enable = true;

  #   # set aliases
  #   shellAliases = {
  #     ls = "eza";
  #     ff = "fastfetch";
  #     search = "nix search nixpkgs";
  #     rebuild = "nh os switch . -H andme";
  #     cat = "bat";
  #     top = "btop";
  #     htop = "btop";
  #   };
  # };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";
}
