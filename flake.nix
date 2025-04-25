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
    hyprland.url = "github:hyprwm/Hyprland";

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
      home-manager,
      hyprland,
      nix-search-tv,
      nixpkgs,
      nixvim,
      rust-overlay,
      self,
      solaar,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      user = "andme";
      hostname = "GiovanGianFranco";
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

          # Stylix
          inputs.stylix.nixosModules.stylix

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

          # Pacchetti
          {
            environment.systemPackages = with pkgs; [
              xorg.libxcb
              xorg.libXcursor
            ];
          }

          # Portale xdg
          {
            services.dbus.enable = true;

            xdg.portal = {
              enable = true;
              wlr.enable = true;
              config.common.default = [ "hyprland" ];
              extraPortals = with pkgs; [
                xdg-desktop-portal-hyprland
                xdg-desktop-portal-gtk
              ];
            };
            services.dbus.packages = with pkgs; [
              xdg-desktop-portal-hyprland
              xdg-desktop-portal-gtk
            ];
          }

          home-manager.nixosModules.home-manager

          {
            home-manager.useUserPackages = true;

            home-manager.users.andme = {
              home.stateVersion = "25.05";
              imports = [
                ./home-manager/home.nix
                inputs.nixvim.homeManagerModules.nixvim
              ];
            };
          }

        ];
        specialArgs = { inherit inputs system; };
      };

      # homeConfigurations."${user}@${hostname}" = home-manager.lib.homeManagerConfiguration {
      #   pkgs = pkgs;
      #   system = system;
      #   home.stateVersion = "25.05";
      #   modules = [

      #     ./home-manager/home.nix

      #     inputs.nixvim.homeManagerModules.nixvin

      #     #{
      #     # wayland.windowManager.hyprland = {
      #     #   enable = true;
      #     #   # Flake
      #     #   package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      #     #   portalPackage =
      #     #     inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      #     # };
      #     #}
      #   ];
      # };
    };
}
