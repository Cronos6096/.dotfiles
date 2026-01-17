{ lib, ... }:
with lib;
{
  options.moduli = {
    system = {
      adb.enable = mkEnableOption "Android Debug Bridge";
      docker.enable = mkEnableOption "Docker";
      lingua.enable = mkEnableOption "Language settings";
      ly.enable = mkEnableOption "Ly display manager";
      niri.enable = mkEnableOption "Niri window manager";
      ollama.enable = mkEnableOption "Ollama";
      plasma.enable = mkEnableOption "Plasma desktop environment";
      portals.enable = mkEnableOption "XDG portals";
      python.enable = mkEnableOption "Python";
      servizi.enable = mkEnableOption "System services";
      solaar.enable = mkEnableOption "Solaar";
      steam.enable = mkEnableOption "Steam";
      stylix.enable = mkEnableOption "Auto theming";
      vm.enable = mkEnableOption "Virtual machines";
      vr.enable = mkEnableOption "VR";
    };

    home-manager = {
      direnv.enable = mkEnableOption "Direnv";
      distrobox.enable = mkEnableOption "Distrobox";
      dunst.enable = mkEnableOption "Dunst daemon";
      git.enable = mkEnableOption "Git";
      hyprland.enable = mkEnableOption "Hyprland window manager";
      kitty.enable = mkEnableOption "Kitty";
      niri.enable = mkEnableOption "Niri window manager (home-manager)";
      noctalia.enable = mkEnableOption "Noctalia shell";
      rofi.enable = mkEnableOption "Rofi app launcher";
      terminale.enable = mkEnableOption "Terminale";
      waybar.enable = mkEnableOption "Waybar";
      wezterm.enable = mkEnableOption "WezTerm terminal";
      wlsunset.enable = mkEnableOption "Wl-sunset";
      zen.enable = mkEnableOption "Zen browser";
    };
  };
}
