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

  nixpkgs.overlays = [ inputs.nix-cachyos-kernel.overlays.pinned ];
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-x86_64-v4;

  boot.loader.systemd-boot.enable = lib.mkForce false;

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
    configurationLimit = 10;
  };

  boot.loader.efi.canTouchEfiVariables = true;
}
