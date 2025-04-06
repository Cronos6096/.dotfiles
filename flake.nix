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

    # Nix-citizen
    nix-citizen.url = "github:LovingMelody/nix-citizen";
    nix-gaming.url = "github:fufexan/nix-gaming";
    nix-citizen.inputs.nix-gaming.follows = "nix-gaming";

    # Hyprland
    hyprland.url = "github:hyprwm/Hyprland";
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";

    # Stylix
    stylix.url = "github:danth/stylix";

    # Solaar
    solaar = {
      url = "https://flakehub.com/f/Svenum/Solaar-Flake/*.tar.gz"; # For latest stable version
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nixvim
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    {
      self,
      nixpkgs,
      solaar,
      home-manager,
      nixvim,
      rust-overlay,
      nix-search-tv,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations = {
        andme = nixpkgs.lib.nixosSystem {
          system = system;
          modules = [
            ./default.nix

            {
              environment.systemPackages = [
                nix-search-tv.packages.x86_64-linux.default
                inputs.nix-citizen.packages.${system}.star-citizen

              ];
            }
            # Stylix
            inputs.stylix.nixosModules.stylix

            # Hyprland
            {
              nixpkgs.overlays = [
                inputs.hyprpanel.overlay
              ];
            }

            (
              { pkgs, ... }:
              {
                nixpkgs.overlays = [
                  rust-overlay.overlays.default
                ];
                environment.systemPackages = [ pkgs.rust-bin.stable.latest.default ];
              }
            )

            # Integrazione di solaar
            solaar.nixosModules.default

            # Integrazione di Home Manager tramite modulo NixOS
            home-manager.nixosModules.home-manager
            {
              home-manager.useUserPackages = true;
              home-manager.users.andme =
                { pkgs, ... }:
                {
                  imports = [
                    inputs.nixvim.homeManagerModules.nixvim
                    ./home.nix
                  ];
                };
            }
          ];
          specialArgs = { inherit inputs; };
          specialArgs = { inherit system; };
        };
      };
    };
}
