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
    hyprland-plugins = {
      url = "github:hyprwm/Hyprland-Plugins";
      inputs.hyprland.follows = "hyprland";
    };

    # Anyrun  
    anyrun = {
      url = "github:anyrun-org/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Solaar
    solaar = {
      url =
        "https://flakehub.com/f/Svenum/Solaar-Flake/*.tar.gz"; # For latest stable version
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, nixpkgs, solaar, home-manager, hyprland, anyrun, ... }@inputs:
    let system = "x86_64-linux";
    in {
      # Configurazione NixOS con integrazione di Home Manager
      nixosConfigurations = {
        andme = nixpkgs.lib.nixosSystem {
          system = system;
          modules = [
            ./configuration.nix
            ./programs/Vm.nix

            # Integrazione di solaar  
            solaar.nixosModules.default

            # Integrazione di Anyrun
            {
              environment.systemPackages = [ anyrun.packages.${system}.anyrun ];
            }

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
