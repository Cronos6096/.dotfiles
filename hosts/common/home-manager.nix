{
  inputs,
  self,
  ...
}:
{
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;

    users.andme = {
      imports = [
        "${self}/modules/home-manager"
        ./home.nix
        inputs.nix-index-database.homeModules.default
      ];

      home = {
        username = "andme";
        homeDirectory = "/home/andme";
        stateVersion = "26.05";
        enableNixpkgsReleaseCheck = false;

        sessionVariables = {
          EDITOR = "nvim";
          VISUAL = "nvim";
        };
      };
    };
  };
}
