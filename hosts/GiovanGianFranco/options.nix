{
  lib,
  ...
}:
with lib;
{
  moduli.system = {
    ai.enable = true;
    docker.enable = false;
    hyprland.enable = true;
    locale.enable = true;
    ly.enable = true;
    portals.enable = false;
    services.enable = true;
    steam.enable = true;
    vm.enable = true;
    vr.enable = true;
  };
}
