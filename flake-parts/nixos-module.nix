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
      system = "x86_64-linux";
      specialArgs = { inherit inputs self; };
      modules = [
        "${self}/moduli/system"
        "${self}/moduli/options.nix"
        "${self}/flake-parts/GiovanGianFranco/home-manager.nix"
        "${self}/flake-parts/GiovanGianFranco/neovim.nix"
        "${self}/flake-parts/GiovanGianFranco/secrets.nix"
        "${self}/flake-parts/GiovanGianFranco/system.nix"
        "${self}/nix"
        "${self}/sys/GiovanGianFranco"
        inputs.home-manager.nixosModules.home-manager
        inputs.lanzaboote.nixosModules.lanzaboote
        inputs.nur.modules.nixos.default
        inputs.solaar.nixosModules.default
        inputs.stylix.nixosModules.stylix
      ];
    };

    rpi5 = inputs.nixos-raspberrypi.lib.nixosSystemFull {
      system = "aarch64-linux";
      specialArgs = {
        inherit inputs self;
        inherit (inputs) nixos-raspberrypi;
      };

      modules = [
        "${self}/flake-parts/rpi5/base.nix"
        "${self}/flake-parts/rpi5/kernel.nix"
        "${self}/flake-parts/rpi5/secrets.nix"
        "${self}/nix/"
        "${self}/sys/rpi"
        inputs.disko.nixosModules.disko
      ];
    };
  };
}
