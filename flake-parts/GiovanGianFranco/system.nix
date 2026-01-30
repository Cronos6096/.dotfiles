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
    inputs.nix-search-tv.packages.${pkgs.system}.default
    pkgs.sbctl
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.loader.systemd-boot.enable = lib.mkForce false;

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
    configurationLimit = 10;
  };

  boot.loader.efi.canTouchEfiVariables = true;
}
