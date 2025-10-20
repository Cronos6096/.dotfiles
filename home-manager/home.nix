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
    EDITOR = "nvim";
    VISUAL = "nvim";
    BROWSER = "zen";
    TERMINAL = "kitty";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_CACHE_HOME = "\${HOME}/.cache";
    XDG_CONFIG_HOME = "\${HOME}/.config";
    XDG_BIN_HOME = "\${HOME}/.local/bin";
  };

  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "25.11";
}
