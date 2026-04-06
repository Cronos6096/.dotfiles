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
        ../../home-manager/home.nix
        inputs.zen-browser.homeModules.default
        inputs.noctalia.homeModules.default
        inputs.nix-index-database.homeModules.default
      ];
      home.enableNixpkgsReleaseCheck = false;
    };
  };
}
