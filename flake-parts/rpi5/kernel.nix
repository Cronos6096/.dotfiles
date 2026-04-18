{
  pkgs,
  lib,
  ...
}:
let
  kernelBundle = pkgs.linuxAndFirmware.default;
in
{
  boot = {
    loader.raspberry-pi.firmwarePackage = kernelBundle.raspberrypifw;
    loader.raspberry-pi.bootloader = "kernel";
    kernelPackages = kernelBundle.linuxPackages_rpi5;
  };

  nixpkgs.overlays = lib.mkAfter [
    (self: super: {
      inherit (kernelBundle) raspberrypiWirelessFirmware;
      inherit (kernelBundle) raspberrypifw;
    })
  ];
}
