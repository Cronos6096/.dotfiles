{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprland
    hyprland.url = "github:hyprwm/Hyprland";

    # Stylix
    stylix.url = "github:danth/stylix";

    # Solaar
    solaar = {
      url =
        "https://flakehub.com/f/Svenum/Solaar-Flake/*.tar.gz"; # For latest stable version
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, solaar, home-manager, ... }@inputs:
    let system = "x86_64-linux";
    in {
      nixosConfigurations = {
        andme = nixpkgs.lib.nixosSystem {
          system = system;
          modules = [
            ./configuration.nix
            programs/Vm.nix
            
            # Stylix
            inputs.stylix.nixosModules.stylix

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
