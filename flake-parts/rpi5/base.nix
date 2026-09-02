{
  inputs,
  ...
}:
{
  imports = [
    ../../moduli/options.nix
    ../../sys/rpi/options.nix
    inputs.nixos-hardware.nixosModules.raspberry-pi-5
  ];

  nixpkgs.overlays = [
    (final: prev: {
      valkey = prev.valkey.overrideAttrs { doCheck = false; };
      redis = prev.redis.overrideAttrs { doCheck = false; };
    })
  ];

  boot.tmp.useTmpfs = true;
}