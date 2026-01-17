{ lib, ... }:
with lib;
{
  imports = [
    ./Direnv.nix
    ./Distrobox.nix
    ./Dunst.nix
    ./Git.nix
    ./Hyprland.nix
    ./Kitty.nix
    ./Noctalia.nix
    ./Terminale.nix
    ./Waybar.nix
    ./WlSunset.nix
    ./Zen.nix
    ./rofi
    ./wezterm
  ];

  config.moduli.home-manager = {
    direnv.enable = mkDefault false;
    distrobox.enable = mkDefault false;
    dunst.enable = mkDefault false;
    git.enable = mkDefault false;
    hyprland.enable = mkDefault false;
    kitty.enable = mkDefault false;
    niri.enable = mkDefault false;
    noctalia.enable = mkDefault false;
    rofi.enable = mkDefault false;
    terminale.enable = mkDefault false;
    waybar.enable = mkDefault false;
    wezterm.enable = mkDefault false;
    wlsunset.enable = mkDefault false;
    zen.enable = mkDefault false;
  };
}
