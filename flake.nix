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

    # Nvf
    nvf.url = "github:notashelf/nvf";

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
      nur,
      nvf,
      rust-overlay,
      self,
      solaar,
      stylix,
      walker,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      # user = "andme";
      # hostname = "GiovanGianFranco";
    in
    {
      packages.${system}.default =
        (nvf.lib.neovimConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = [ ./moduli/system/Nvf.nix ];
        }).neovim;

      nixosConfigurations = {
        # Laptop
        andme = nixpkgs.lib.nixosSystem {
          system = system;
          modules = [
            ./sys

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

            # Dolphin
            (
              { pkgs, ... }:
              {
                xdg.menus.enable = true;
                xdg.mime.enable = true;

                environment.etc."xdg/menus/applications.menu".source =
                  "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/applications.menu";

                environment.systemPackages = with pkgs; [
                  kdePackages.dolphin
                  xdg-utils
                ];
              }
            )

            home-manager.nixosModules.home-manager

            {
              home-manager.useUserPackages = true;
              home-manager.users.andme = {
                home.stateVersion = "25.05";
                imports = [
                  ./home-manager/home.nix
                  inputs.nixvim.homeManagerModules.nixvim
                  inputs.walker.homeManagerModules.default
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

        # Pi5
        # pi5 = nixpkgs.lib.nixosSystem {
        #   # system = "aarch64-linux";
        #   modules = [
        #     ./sys
        #     # Pi5 hardware
        #     inputs.nixos-hardware.raspberry-pi-5
        #     home-manager.nixosModules.home-manager
        #   ];
        # };
      };
    };
}
