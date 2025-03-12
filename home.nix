{
  imports = [ moduli/Terminale.nix ./pacchetti.nix moduli/Git.nix ];

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

  home.stateVersion = "25.05";
}
