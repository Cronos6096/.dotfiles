{
  lib,
  ...
}:
with lib;
{
  imports = [
    ./options.nix

    ./Direnv.nix
    ./Distrobox.nix
    ./Git.nix
    ./Hyprland.nix
    ./Kitty.nix
    ./Noctalia.nix
    ./Terminal.nix
    ./Waybar.nix
    ./Zen.nix
  ];

  config.moduli.home-manager = {
    direnv.enable = mkDefault false;
    distrobox.enable = mkDefault false;
    git.enable = mkDefault false;
    hyprland.enable = mkDefault false;
    kitty.enable = mkDefault false;
    noctalia.enable = mkDefault false;
    terminal.enable = mkDefault false;
    waybar.enable = mkDefault false;
    zen.enable = mkDefault false;
  };
}
