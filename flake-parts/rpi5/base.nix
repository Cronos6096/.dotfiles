{
  config,
  pkgs,
  lib,
  nixos-raspberrypi,
  ...
}:
{
  imports = with nixos-raspberrypi.nixosModules; [
    raspberry-pi-5.base
    raspberry-pi-5.page-size-16k
    raspberry-pi-5.display-vc4
  ];

  boot.tmp.useTmpfs = true;
}
