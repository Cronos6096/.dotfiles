{
  programs.home-manager.enable = true;

  imports = [
    ./pacchetti.nix
    ./homeImports.nix
  ];

  home.username = "andme";
  home.homeDirectory = "/home/andme";
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    BROWSER = "floorp";
    TERMINAL = "kitty";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";
    GTK_USE_PORTAL = "1";
  };

  # Polkit
  xdg.autostart.enable = true;

  nixpkgs.config.allowUnfree = true;
  # home.stateVersion = "25.05";
}
