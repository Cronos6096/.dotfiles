{
  nixos-raspberrypi,
  self,
  lib,
  ...
}: let
  rpiPkgs = "${nixos-raspberrypi}/pkgs/raspberrypi";
in {
  imports = [
    ../../moduli/options.nix
    ../../sys/rpi/options.nix
  ]
  ++ (with nixos-raspberrypi.nixosModules; [
    raspberry-pi-5.base
    raspberry-pi-5.page-size-16k
    raspberry-pi-5.display-vc4
  ]);

  nixpkgs.overlays = [
    nixos-raspberrypi.overlays.vendor-kernel
    nixos-raspberrypi.overlays.vendor-firmware
    nixos-raspberrypi.overlays.kernel-and-firmware
    (final: prev: {
      libraspberrypi = prev.callPackage "${rpiPkgs}/libraspberrypi.nix" { };
      raspberrypi-userland = final.libraspberrypi;
      rpi-userland = final.libraspberrypi;
      raspberrypi-utils = prev.callPackage "${rpiPkgs}/raspberrypi-utils.nix" { };
      raspberrypi-udev-rules = prev.callPackage "${rpiPkgs}/udev-rules.nix" { };
      valkey = prev.valkey.overrideAttrs { doCheck = false; };
      redis = prev.redis.overrideAttrs { doCheck = false; };
    })
  ];

  boot.tmp.useTmpfs = true;
}
