{ pkgs, ... }:
{
  programs.home-manager.enable = true;

  imports = [
    ./pacchetti.nix
    ../moduli/home-manager
    ../moduli/options.nix
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

  moduli.home-manager = {
    direnv.enable = true;
    distrobox.enable = true;
    dunst.enable = true;
    git.enable = true;
    hyprland.enable = true;
    kitty.enable = true;
    niri.enable = true;
    noctalia.enable = true;
    rofi.enable = true;
    terminale.enable = true;
    waybar.enable = true;
    wezterm.enable = false;
    wlsunset.enable = false;
    zen.enable = true;
  };

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/evenok-dark.yaml";
  };

  home.stateVersion = "26.05";

  # VR
  xdg.configFile."openxr/1/active_runtime.json".source =
    "${pkgs.wivrn}/share/openxr/1/openxr_wivrn.json";

}
