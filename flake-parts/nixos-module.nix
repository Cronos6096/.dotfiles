{
  inputs,
  self,
  ...
}:
{
  systems = [
    "x86_64-linux"
    "aarch64-linux"
  ];

  perSystem =
    { pkgs, ... }:
    let
      nvfConfig = inputs.nvf.lib.neovimConfiguration {
        inherit pkgs;
        modules = [ (import ../moduli/system/Nvf) ];
      };
      nvfPackage = nvfConfig.neovim;
    in
    {
      packages.default = nvfPackage;
      apps.default = {
        type = "app";
        program = "${nvfPackage}/bin/nvim";
      };
    };

  flake.nixosConfigurations = {
    GiovanGianFranco = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs self; };
      modules = [
        "${self}/moduli/system"
        "${self}/moduli/options.nix"
        "${self}/flake-parts/GiovanGianFranco"
        "${self}/nix"
        "${self}/sys/GiovanGianFranco"
        inputs.home-manager.nixosModules.home-manager
        inputs.lanzaboote.nixosModules.lanzaboote
        inputs.stylix.nixosModules.stylix
        inputs.nur.modules.nixos.default
      ];
    };

    rpi5 = inputs.nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";

      specialArgs = { inherit inputs self; };

      modules = [
        "${self}/flake-parts/rpi5/"
        "${self}/nix/"
        "${self}/sys/rpi"
        inputs.disko.nixosModules.disko
        inputs.home-manager.nixosModules.home-manager
      ];
    };

    tablet = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs self; };

      modules = [
        "${self}/moduli/system"
        "${self}/moduli/options.nix"
        "${self}/flake-parts/tablet/"
        "${self}/nix/"
        "${self}/sys/tablet"
        inputs.home-manager.nixosModules.home-manager
        inputs.stylix.nixosModules.stylix
      ];
    };
  };
}
