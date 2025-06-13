{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nur
    nur = {
      url = "github:nix-community/NUR";
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

    # Dolphin
    dolphin-overlay.url = "github:rumboon/dolphin-overlay";

    # Nvf
    nvf.url = "github:notashelf/nvf";

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

    # Nixvim
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Rust
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      home-manager,
      hyprland,
      nix-search-tv,
      nixpkgs,
      nixvim,
      nur,
      nvf,
      rust-overlay,
      self,
      solaar,
      stylix,
      dolphin-overlay,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
    in
    {
      # Nvf
      packages.${system}.default =
        (nvf.lib.neovimConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = [ ./moduli/system/Nvf.nix ];
        }).neovim;

      nixosConfigurations = {

        # Laptop
        andme = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./sys
            ./moduli/system/Portals.nix

            # Nvf
            nvf.nixosModules.default

            # Nix search
            {
              environment.systemPackages = [
                nix-search-tv.packages.x86_64-linux.default
              ];
            }

            # NUR
            nur.modules.nixos.default

            # Dolphin
            {
              nixpkgs.overlays = [ dolphin-overlay.overlays.default ];
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

            # Modulo di Stylix NixOS
            stylix.nixosModules.stylix

            # Home-manager
            home-manager.nixosModules.home-manager

            {
              home-manager.useUserPackages = true;
              home-manager.users.andme = {
                imports = [
                  ./home-manager/home.nix
                  inputs.nixvim.homeManagerModules.nixvim
                ];
              };
            }
          ];
          specialArgs = {
            inherit
              inputs
              system
              ;
          };
        };
      };
    };
}
