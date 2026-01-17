{
  nixos-raspberrypi,
  self,
  lib,
  ...
}:
{
  imports = [
    ../../moduli/options.nix
    ../../sys/rpi/options.nix
  ]
  ++ (with nixos-raspberrypi.nixosModules; [
    raspberry-pi-5.base
    raspberry-pi-5.page-size-16k
    raspberry-pi-5.display-vc4
  ]);

  boot.tmp.useTmpfs = true;
}
