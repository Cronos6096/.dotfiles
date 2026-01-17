{ lib, ... }:
with lib;
{
  imports = [
    ./Adb.nix
    ./Docker.nix
    ./Lingua.nix
    ./Ly.nix
    ./Niri.nix
    ./Ollama.nix
    ./Plasma.nix
    ./Portals.nix
    ./Servizi.nix
    ./Solaar.nix
    ./Steam.nix
    ./Stylix.nix
    ./Vm.nix
    ./Vr.nix
  ];

  config.moduli.system = {
    adb.enable = mkDefault false;
    docker.enable = mkDefault false;
    lingua.enable = mkDefault false;
    ly.enable = mkDefault false;
    niri.enable = mkDefault false;
    ollama.enable = mkDefault false;
    plasma.enable = mkDefault false;
    portals.enable = mkDefault false;
    servizi.enable = mkDefault false;
    solaar.enable = mkDefault false;
    steam.enable = mkDefault false;
    stylix.enable = mkDefault false;
    vm.enable = mkDefault false;
    vr.enable = mkDefault false;
  };
}
