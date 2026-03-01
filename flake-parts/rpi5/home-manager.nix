{
  inputs,
  ...
}:
{
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    backupFileExtension = "backup";
    users.andme = {
      imports = [
        ../../moduli/home-manager/Terminale.nix
        ../../moduli/options.nix
      ];
      home = {
        username = "andme";
        homeDirectory = "/home/andme";
        sessionVariables = {
          EDITOR = "nvim";
          VISUAL = "nvim";
        };
        stateVersion = "25.11";
      };
      moduli.home-manager.terminale.enable = true;
    };
  };
}
