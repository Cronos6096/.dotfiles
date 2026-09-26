{
  lib,
  ...
}:
with lib;
{
  options.moduli.system = {
    ai.enable = mkEnableOption "AI tooling (LM Studio)";
    docker.enable = mkEnableOption "Docker";
    hyprland.enable = mkEnableOption "Hyprland compositor";
    locale.enable = mkEnableOption "Locale and keyboard layout";
    ly.enable = mkEnableOption "Ly display manager";
    portals.enable = mkEnableOption "XDG portals";
    services.enable = mkEnableOption "Desktop integration services";
    steam.enable = mkEnableOption "Steam";
    vm.enable = mkEnableOption "Virtual machines";
    vr.enable = mkEnableOption "VR";
  };
}
