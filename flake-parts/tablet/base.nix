{
  inputs,
  ...
}:
{
  imports = [
    ../../moduli/options.nix
    ../../sys/tablet/options.nix
  ];

  nixpkgs.overlays = [
    inputs.droidspaces.overlays.default
  ];
}
