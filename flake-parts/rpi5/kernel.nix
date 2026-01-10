{
  config,
  pkgs,
  lib,
  ...
}:
let
  kernelBundle = pkgs.linuxAndFirmware.v6_6_31;
in
{
  boot = {
    loader.raspberryPi.firmwarePackage = kernelBundle.raspberrypifw;
    loader.raspberryPi.bootloader = "kernel";
    kernelPackages = kernelBundle.linuxPackages_rpi5;
  };

  nixpkgs.overlays = lib.mkAfter [
    (self: super: {
      inherit (kernelBundle) raspberrypiWirelessFirmware;
      inherit (kernelBundle) raspberrypifw;
    })
  ];
}
