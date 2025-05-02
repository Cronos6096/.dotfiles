{
  pkgs,
  lib,
  inputs,
  ...
}:

{
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland.enable = true;
    systemd.enable = true;
    plugins = [ inputs.Hyprspace.packages.${pkgs.system}.Hyprspace ];
  };

  home.file."/home/andme/.config/hypr/hyprland.conf".source = lib.mkForce ../../hypr/hyprland.conf;
  # home.file.".config/hypr/hyprpaper.conf".source = ../hypr/hyprpaper.conf;
}
