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
        inputs.nix-index-database.homeModules.default
      ];
      home = {
        username = "andme";
        homeDirectory = "/home/andme";
        sessionVariables = {
          EDITOR = "nvim";
          VISUAL = "nvim";
        };
        stateVersion = "26.05";
        enableNixpkgsReleaseCheck = false;
      };
      moduli.home-manager = {
        terminale.enable = true;
      };
    };
  };
}
