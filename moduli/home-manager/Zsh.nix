{ pkgs, ... }:
{
  # Nh
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 3d --keep 3";
    flake = "/home/andme/.dotfiles/";
  };

  # zsh shell
  programs.zsh = {
    enable = true;
    enableCompletion = true; # Enables auto completion.
    autosuggestion.enable = true; # Enables autosuggestions.
    syntaxHighlighting.enable = true; # Enables syntax highlighting.

    plugins = [
      {
        name = "vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
    ];

    shellAliases = {
      ls = "eza";
      ff = "fastfetch";
      rebuild = "nh os switch /home/andme/.dotfiles/ -H andme --update";
      rebuildpi = "nh os switch /home/andme/.dotfiles/ -H pi5 --update";
      rebuildnoup = "nh os switch /home/andme/.dotfiles/ -H andme";
      rebuildpush = " cdconf && git add * && git commit && git push && nh os switch . -H andme";
      clean = "nh clean all --keep=5";
      cat = "bat";
      cdconf = "cd /home/andme/.dotfiles";
      cdpr = "cd /home/andme/progetti";
      nvf = "nix run /home/andme/.dotfiles/ --";
      nvfconfig = "nix run /home/andme/.dotfiles/ -- /home/andme/.dotfiles/moduli/system/Nvf.nix";
      py = "python";
      py3 = "python3";
      bottles = "flatpak run com.usebottles.bottles";
      nixsearch = "nix-search-tv print | fzf --preview 'nix-search-tv preview {}' --scheme history";
      arch = "distrobox-enter arch";
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
