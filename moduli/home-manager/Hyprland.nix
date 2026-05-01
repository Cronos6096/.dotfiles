{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
{
  config = mkIf config.moduli.home-manager.hyprland.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      package = null;
      portalPackage = null;
    };

    home = {
      file."/home/andme/.config/hypr/hyprland.conf".source =
        config.lib.file.mkOutOfStoreSymlink ../../moduli/wm/hypr/hyprland.conf;
      file."/home/andme/.config/pypr/config.toml".source =
        config.lib.file.mkOutOfStoreSymlink ../../moduli/wm/hypr/pyprland.toml;

      packages = with pkgs; [
        wl-clipboard
        clipse
        hyprshot
        pavucontrol
        networkmanager
        handlr
        hyprsome
        pyprland
        jq
        awww
        waypaper
        hyprmon
        bibata-cursors
        vicinae
      ];
    };
  };
}
