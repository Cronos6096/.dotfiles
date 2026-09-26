{
  lib,
  ...
}:
with lib;
{
  # NOTE: this namespace is only ever declared inside a home-manager module
  # evaluation. Setting it from a NixOS module is a no-op, which is why each
  # host keeps a separate `home-options.nix`.
  options.moduli.home-manager = {
    direnv.enable = mkEnableOption "Direnv";
    distrobox.enable = mkEnableOption "Distrobox";
    git.enable = mkEnableOption "Git";
    hyprland.enable = mkEnableOption "Hyprland configuration";
    kitty.enable = mkEnableOption "Kitty";
    noctalia.enable = mkEnableOption "Noctalia shell";
    terminal.enable = mkEnableOption "Terminal environment";
    waybar.enable = mkEnableOption "Waybar";
    zen.enable = mkEnableOption "Zen browser";
  };
}
