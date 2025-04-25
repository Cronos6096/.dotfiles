{lib, ...}:

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

  home.file."/home/andme/.config/hypr/hyprland.conf".source = lib.mkForce ../hypr/hyprland.conf;
  # home.file.".config/hypr/hyprpaper.conf".source = ../hypr/hyprpaper.conf;

  # Polkit
  xdg.autostart.enable = true;

  nixpkgs.config.allowUnfree = true;
  # home.stateVersion = "25.05";
}
