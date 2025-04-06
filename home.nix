{
  imports = [
    moduli/Terminale.nix
    ./pacchetti.nix
    moduli/Git.nix
    moduli/Stylix.nix
    moduli/Nixvim/default.nix
  ];

  # Home Manager
  programs.home-manager.enable = true;

  home.username = "andme";
  home.homeDirectory = "/home/andme";

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    BROWSER = "floorp";
    TERMINAL = "kitty";
  };

  # Polkit
  xdg.autostart.enable = true;

  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "25.05";
}
