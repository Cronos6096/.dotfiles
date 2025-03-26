{
  description = "NixOS configuration";

  inputs = {
    imports = [moduli/Rust.nix];
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprland
    hyprland.url = "github:hyprwm/Hyprland";
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";

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

            # Stylix
            inputs.stylix.nixosModules.stylix
            {
              nixpkgs.overlays = [ inputs.hyprpanel.overlay ];
            }
            # Integrazione di solaar  
            solaar.nixosModules.default

            # Integrazione di Home Manager tramite modulo NixOS
            home-manager.nixosModules.home-manager
            {
              home-manager.useUserPackages = true;
              home-manager.users.andme = import ./home.nix;
            }
          ];
          specialArgs = { inherit inputs; };
          specialArgs = { inherit system; };

        };
      };
    };
}
