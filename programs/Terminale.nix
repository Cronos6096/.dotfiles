{
  # Nh
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/andme/.dotfiles/";
  };

  # Terminale
  # programs.ghostty = { enable = true; };
  programs.kitty = { enable = true; };

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
      rebuild = "nh os switch . -H andme";
      update = "nh os update";
      uprebuild = "git add * && git commit && git push && nh os switch . -H andme && reboot";
      cat = "bat";
      top = "btop";
      htop = "btop";
      cdconfig = "cd /home/andme/.dotfiles";
      nvim = "lvim";
      vim = "lvim";
      vi = "lvim";
    };
    history.size = 10000;

    # oh-my-zsh
    oh-my-zsh = {
      enable = true;
      plugins =
        [ "vscode" "zsh-interactive-cd" "fzf" ]; # vsc per aprire vscode
      theme = "robbyrussell";
    };
  };

  programs.starship = {
    enableZshIntegration = true;
    enable = true;
  };
}
