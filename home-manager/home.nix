{ pkgs, ... }:
{
  programs.home-manager.enable = true;

  imports = [
    ./pacchetti.nix
    ../moduli/home-manager
  ];

  home.username = "andme";
  home.homeDirectory = "/home/andme";
  home.sessionVariables = {
    EDITOR = "nix run /home/andme/.dotfiles/ --";
    VISUAL = "nix run /home/andme/.dotfiles/ --";
    BROWSER = "floorp";
    TERMINAL = "wezterm";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_CACHE_HOME = "\${HOME}/.cache";
    XDG_CONFIG_HOME = "\${HOME}/.config";
    XDG_BIN_HOME = "\${HOME}/.local/bin";
  };

  # Polkit
  xdg.autostart.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-gtk
  ];

  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "25.05";
}
