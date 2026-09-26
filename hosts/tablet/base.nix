{
  inputs,
  ...
}:
{
  nixpkgs.overlays = [ inputs.droidspaces.overlays.default ];
}
