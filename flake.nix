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
    hyprland.url = "github:hyprwm/Hyprland";
    split-monitor-workspaces = {
      url = "github:Duckonaut/split-monitor-workspaces";
      inputs.hyprland.follows = "hyprland";
    };

    # Stylix
    stylix.url = "github:danth/stylix";

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

    # Walker
    walker.url = "github:abenz1267/walker";

  };

  outputs =
    {
      home-manager,
      hyprland,
      nix-search-tv,
      nixpkgs,
      nixvim,
      rust-overlay,
      self,
      solaar,
      stylix,
      walker,
      nur,
      split-monitor-workspaces,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      user = "andme";
      # hostname = "GiovanGianFranco";
    in
    {
      nixosConfigurations."${user}" = nixpkgs.lib.nixosSystem {
        system = system;
        modules = [
          ./sys

          # Nix search
          {
            environment.systemPackages = [
              nix-search-tv.packages.x86_64-linux.default
            ];
          }

          # NUR
          nur.modules.nixos.default

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

          # Portale xdg
          {
            autoXdgPortal.enable = true;
          }

          home-manager.nixosModules.home-manager

          {
            home-manager.useUserPackages = true;
            home-manager.users.andme = {
              home.stateVersion = "25.05";
              imports = [
                ./home-manager/home.nix
                inputs.nixvim.homeManagerModules.nixvim
                inputs.walker.homeManagerModules.default
                # stylix.homeManagerModules.stylix
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
}
