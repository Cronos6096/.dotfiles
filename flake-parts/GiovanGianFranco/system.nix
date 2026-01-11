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

  # Use standard kernel for compatibility
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.loader.systemd-boot.enable = lib.mkForce false;

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };
}
