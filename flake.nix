{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    # Assicura che home-manager usi lo stesso nixpkgs
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-citizen.url = "github:LovingMelody/nix-citizen";
    nix-gaming.url = "github:fufexan/nix-gaming";
    nix-citizen.inputs.nix-gaming.follows = "nix-gaming";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
    in {
      # Configurazione NixOS con integrazione di Home Manager
      nixosConfigurations = {
        andme = nixpkgs.lib.nixosSystem {
          system = system;
          modules = [
            ./configuration.nix
            # Integrazione di Home Manager tramite modulo NixOS
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.andme = import ./home.nix;
            }
          ];
          specialArgs = { inherit inputs; };
        };
      };
    };
}