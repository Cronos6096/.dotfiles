{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NixOS Cosmic
    nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";

    # Solaar
    solaar = {
      url =
        "https://flakehub.com/f/Svenum/Solaar-Flake/*.tar.gz"; # For latest stable version
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, solaar, home-manager, nixos-cosmic, ... }@inputs:
    let system = "x86_64-linux";
    in {
      # Configurazione NixOS con integrazione di Home Manager
      nixosConfigurations = {
        andme = nixpkgs.lib.nixosSystem {
          system = system;
          modules = [
            ./configuration.nix
            programs/Vm.nix

            {
              nix.settings = {
                substituters = [ "https://cosmic.cachix.org/" ];
                trusted-public-keys = [
                  "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
                ];
              };
            }
            nixos-cosmic.nixosModules.default

            # Integrazione di solaar  
            solaar.nixosModules.default

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
