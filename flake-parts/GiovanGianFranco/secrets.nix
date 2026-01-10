{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.agenix.nixosModules.default
    ../../secrets.nix
  ];

  environment.systemPackages = [ inputs.agenix.packages.${pkgs.system}.default ];
  age.identityPaths = [ "/home/andme/.ssh/id_ed25519" ];
}
