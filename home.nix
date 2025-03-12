{pkgs, ...}:
{
  imports = [ moduli/Terminale.nix ./pacchetti.nix ];

  # Home Manager
  programs.home-manager.enable = true;

  home.username = "andme";
  home.homeDirectory = "/home/andme";

  home.sessionVariables = {
    EDITOR = "lvim";
    VISUAL = "lvim";
    BROWSER = "floorp";
    TERMINAL = "ghostty";
  };

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
