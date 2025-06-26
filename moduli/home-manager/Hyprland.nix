{
  pkgs,
  lib,
  ...
}:

{
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
    xwayland.enable = true;
    systemd.enable = true;
  };

  home.file."/home/andme/.config/hypr/hyprland.conf".source = lib.mkForce ../wm/hypr/hyprland.conf;

  home.packages = with pkgs; [
    dunst
    wofi
    wl-clipboard
    clipse
    hyprshot
    pavucontrol
    networkmanager
    handlr
    hyprsome
    hyprpaper
  ];
}
