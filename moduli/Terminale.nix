{
  # Nh
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 3d --keep 3";
    flake = "/home/andme/.dotfiles/";
  };

  # Terminale
  programs.ghostty = {
    enable = true;
    settings = {
      font-family = "Fira Code";
      font-size = 14;
      theme = "stylix";
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
      z = "zoxide";
      ff = "fastfetch";
      search = "nix search nixpkgs";
      rebuild = "nh os switch /home/andme/.dotfiles/flake.nix -H andme --update";
      uprebuild = "git add * && git commit && git push && nh os switch . -H andme && reboot";
      cat = "bat";
      cdconf = "cd /home/andme/.dotfiles";
      cdpr = "cd /home/andme/progetti";
      v = "lvim";
      py = "python";
      py3 = "python3";
      bottles = "flatpak run com.usebottles.bottles";
    };
    history.size = 10000;

    # oh-my-zsh
    oh-my-zsh = {
      enable = true;
      plugins = [
        "vscode"
        "zsh-interactive-cd"
        "fzf"
      ]; # vsc per aprire vscode
      theme = "robbyrussell";
    };
  };

  programs.starship = {
    enableZshIntegration = true;
    enable = true;
  };
}
