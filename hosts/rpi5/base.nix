{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.nixos-hardware.nixosModules.raspberry-pi-5
  ];

  nixpkgs.overlays = [
    (_final: prev: {
      valkey = prev.valkey.overrideAttrs { doCheck = false; };
      redis = prev.redis.overrideAttrs { doCheck = false; };
    })
  ];

  boot.tmp.useTmpfs = true;

  boot.kernelPackages = pkgs.linuxPackages;
}
