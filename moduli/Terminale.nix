{
  # Nh
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 3d --keep 3";
    flake = "/home/andme/.dotfiles/";
  };

  # Terminale
 programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
    settings = {
      scrollback_lines = 10000;
      confirm_os_window_close = 0;
      cursor_trail_start_threshold = 2;
    };
  };

  # zsh shell
  programs.zsh = {
    enable = true;
    enableCompletion = true; # Enables auto completion.
    autosuggestion.enable = true; # Enables autosuggestions.
    syntaxHighlighting.enable = true; # Enables syntax highlighting.

    shellAliases = {
      ls = "eza";
      ff = "fastfetch";
      search = "nix search nixpkgs";
      rebuild = "nh os switch /home/andme/.dotfiles/ -H andme --update";
      rebuildnoup = "nh os switch /home/andme/.dotfiles/ -H andme";
      rebuildpush = " cdconf && git add * && git commit && git push && nh os switch . -H andme";
      clean = "nh clean all --keep=5";
      cat = "bat";
      cdconf = "cd /home/andme/.dotfiles";
      cdpr = "cd /home/andme/progetti";
      v = "nvim";
      py = "python";
      py3 = "python3";
      bottles = "flatpak run com.usebottles.bottles";
    };
    history.size = 10000;

    # oh-my-zsh
    oh-my-zsh = {
      enable = true;
      plugins = [
        "zsh-interactive-cd"
        "fzf"
      ];
      theme = "robbyrussell";
    };
  };

  programs.starship = {
    enableZshIntegration = true;
    enable = true;
  };
}
