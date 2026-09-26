{
  lib,
  ...
}:
with lib;
{
  moduli.home-manager = {
    direnv.enable = true;
    distrobox.enable = true;
    git.enable = true;
    hyprland.enable = true;
    kitty.enable = true;
    noctalia.enable = true;
    waybar.enable = true;
    zen.enable = true;
  };
}
