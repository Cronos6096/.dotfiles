{
  inputs,
  self,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ../../sys/GiovanGianFranco/options.nix
  ];

  environment.systemPackages = [
    pkgs.sbctl
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    loader.systemd-boot.enable = lib.mkForce false;

    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
      configurationLimit = 10;
    };
  };

  boot.loader.efi.canTouchEfiVariables = true;
}
