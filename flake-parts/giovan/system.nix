{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  environment.systemPackages = [
    inputs.nix-search-tv.packages.${pkgs.system}.default
    pkgs.sbctl
  ];

  nixpkgs.overlays = [ inputs.nix-cachyos-kernel.overlays.default ];
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-x86_64-v4;

  boot.loader.systemd-boot.enable = lib.mkForce false;

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };
}
