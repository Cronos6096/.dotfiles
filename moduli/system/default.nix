{ lib, ... }:
with lib;
{
  imports = [
    ./Docker.nix
    ./Lingua.nix
    ./Ly.nix
    ./Niri.nix
    ./Ai.nix
    ./Plasma.nix
    ./Portals.nix
    ./Servizi.nix
    ./Steam.nix
    ./Stylix.nix
    ./Vm.nix
    ./Vr.nix
  ];

  config.moduli.system = {
    docker.enable = mkDefault false;
    lingua.enable = mkDefault false;
    ly.enable = mkDefault false;
    niri.enable = mkDefault false;
    Ai.enable = mkDefault false;
    plasma.enable = mkDefault false;
    portals.enable = mkDefault false;
    servizi.enable = mkDefault false;
    steam.enable = mkDefault false;
    stylix.enable = mkDefault false;
    vm.enable = mkDefault false;
    vr.enable = mkDefault false;
  };
}
