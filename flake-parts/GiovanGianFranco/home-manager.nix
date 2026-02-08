{
  inputs,
  ...
}:
{
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = false;
    useUserPackages = true;
    backupFileExtension = "backup";
    users.andme = {
      imports = [
        ../../home-manager/home.nix
        inputs.zen-browser.homeModules.default
        inputs.noctalia.homeModules.default
      ];
      nixpkgs.config.allowUnfreePredicate =
        pkg:
        builtins.elem (pkg.pname or "") [
          "steam"
          "steam-unwrapped"
          "steam-runtime"
          "unrar"
        ];
    };
  };
}
