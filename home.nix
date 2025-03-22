{
  imports =
    [ moduli/Terminale.nix ./pacchetti.nix moduli/Git.nix moduli/Stylix.nix ];

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

  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "25.05";
}
