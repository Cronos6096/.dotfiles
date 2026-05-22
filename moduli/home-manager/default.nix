{ lib, ... }:
with lib;
{
  imports = [
    ./Direnv.nix
    ./Distrobox.nix
    ./Git.nix
    ./Hyprland.nix
    ./Kitty.nix
    ./Noctalia.nix
    ./Terminale.nix
    ./Waybar.nix
    ./WlSunset.nix
    ./Zen.nix
  ];

  config.moduli.home-manager = {
    direnv.enable = mkDefault false;
    distrobox.enable = mkDefault false;
    git.enable = mkDefault false;
    hyprland.enable = mkDefault false;
    kitty.enable = mkDefault false;
    niri.enable = mkDefault false;
    noctalia.enable = mkDefault false;
    terminale.enable = mkDefault false;
    waybar.enable = mkDefault false;
    wlsunset.enable = mkDefault false;
    zen.enable = mkDefault false;
  };
}
