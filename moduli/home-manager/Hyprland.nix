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
      file."/home/andme/.config/hypr/hyprland.conf".source = mkForce (
        config.lib.file.mkOutOfStoreSymlink "/home/andme/.dotfiles/moduli/wm/hypr/hyprland.conf"
      );
      file."/home/andme/.config/pypr/config.toml".source =
        config.lib.file.mkOutOfStoreSymlink "/home/andme/.dotfiles/moduli/wm/hypr/pyprland.toml";

      packages = with pkgs; [
        wl-clipboard
        clipse
        hyprshot
        networkmanager
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
