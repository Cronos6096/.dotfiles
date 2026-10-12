{
  lib,
  ...
}:
with lib;
{
  imports = [
    ./options.nix

    ./Nix.nix
    ./Nvim.nix

    ./Ai.nix
    ./Docker.nix
    ./Hyprland.nix
    ./Locale.nix
    ./Ly.nix
    ./Portals.nix
    ./Services.nix
    ./Steam.nix
    ./Vm.nix
    ./Vr.nix
  ];

  config.moduli.system = {
    ai.enable = mkDefault false;
    docker.enable = mkDefault false;
    hyprland.enable = mkDefault false;
    locale.enable = mkDefault false;
    ly.enable = mkDefault false;
    portals.enable = mkDefault false;
    services.enable = mkDefault false;
    steam.enable = mkDefault false;
    vm.enable = mkDefault false;
    vr.enable = mkDefault false;
  };
}
