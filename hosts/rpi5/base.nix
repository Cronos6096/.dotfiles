{
  inputs,
  ...
}:
{
  imports = [
    inputs.nixos-raspberrypi.nixosModules.raspberry-pi-5.base
  ];

  nixpkgs.overlays = [
    (_final: prev: {
      valkey = prev.valkey.overrideAttrs { doCheck = false; };
      redis = prev.redis.overrideAttrs { doCheck = false; };
    })
  ];

  boot.tmp.useTmpfs = true;
}
