{
  inputs,
  ...
}:
{
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    users.andme = {
      imports = [
        ../../home-manager/home.nix
        inputs.zen-browser.homeModules.default
        inputs.noctalia.homeModules.default
      ];
    };
  };
}
