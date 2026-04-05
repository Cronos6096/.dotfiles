{
  inputs,
  self,
  ...
}:
{
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
        inputs.nur.modules.nixos.default
        inputs.stylix.nixosModules.stylix
      ];
    };

    rpi5 = inputs.nixos-raspberrypi.lib.nixosSystemFull {
      specialArgs = {
        inherit inputs self;
        inherit (inputs) nixos-raspberrypi;
      };

      modules = [
        "${self}/flake-parts/rpi5/"
        "${self}/nix/"
        "${self}/sys/rpi"
        inputs.disko.nixosModules.disko
        inputs.home-manager.nixosModules.home-manager
      ];
    };
  };
}
