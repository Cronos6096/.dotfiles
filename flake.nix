{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Trova pacchetti
    nix-search-tv.url = "github:3timeslazy/nix-search-tv";

    # Hyprland
    hyprland = {
      type = "git";
      url = "https://github.com/hyprwm/Hyprland";
      submodules = true;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Stylix
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Solaar
    solaar = {
      url = "https://flakehub.com/f/Svenum/Solaar-Flake/*.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Rust
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
      };
    };

    anyrun = {
      url = "github:anyrun-org/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      anyrun,
      home-manager,
      nix-search-tv,
      nixpkgs,
      solaar,
      stylix,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations = {

        # Laptop
        andme = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./sys
            ./nix
            ./moduli/system/Portals.nix

            # Nix search
            {
              environment.systemPackages = [
                nix-search-tv.packages.x86_64-linux.default
              ];
            }

            # Anyrun
            { environment.systemPackages = [ anyrun.packages.${system}.anyrun-with-all-plugins ]; }

            # Integrazione di solaar
            solaar.nixosModules.default

            # Modulo di Stylix NixOS
            stylix.nixosModules.stylix

            # Home-manager
            home-manager.nixosModules.home-manager

            {
              home-manager.extraSpecialArgs = {
                inherit inputs;
              };

              home-manager.useUserPackages = true;

              home-manager.users.andme = {
                imports = [
                  ./home-manager/home.nix
                  inputs.zen-browser.homeModules.default
                ];
              };
            }
          ];
          specialArgs = { inherit inputs system; };
        };
      };
    };
}
