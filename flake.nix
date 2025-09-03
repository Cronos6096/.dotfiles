{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

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

    # Neovim
    nvf.url = "github:notashelf/nvf";

    # Starcitizen
    nix-citizen.url = "github:LovingMelody/nix-citizen";
  };

  outputs =
    {
      anyrun,
      home-manager,
      nix-search-tv,
      nixpkgs,
      nvf,
      nur,
      solaar,
      stylix,
      self,
      chaotic,
      nix-citizen,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
    in
    {
      # Neovim
      packages.${system}.default =
        (nvf.lib.neovimConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = [ ./moduli/system/Nvf ];
        }).neovim;

      nixosConfigurations = {

        # Laptop
        GiovanGianFranco = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs self; };
          modules = [
            ./sys/GiovanGianFranco
            ./nix
            ./moduli/system/Portals.nix

            # Nix search
            {
              environment.systemPackages = [
                nix-search-tv.packages.x86_64-linux.default
              ];
            }

            # Neovim
            (
              { pkgs, ... }@args:
              {
                environment.systemPackages = [
                  self.packages.${pkgs.system}.default
                ];
              }
            )

            # Nur
            nur.modules.nixos.default

            # Chaotic
            chaotic.nixosModules.default

            # Anyrun
            { environment.systemPackages = [ anyrun.packages.${system}.anyrun-with-all-plugins ]; }

            # Integrazione di solaar
            solaar.nixosModules.default

            # Modulo di Stylix NixOS
            stylix.nixosModules.stylix

            # Starcitizen
            nix-citizen.nixosModules.StarCitizen
            {
              nix.settings = {
                substituters = [ "https://nix-citizen.cachix.org" ];
                trusted-public-keys = [ "nix-citizen.cachix.org-1:lPMkWc2X8XD4/7YPEEwXKKBg+SVbYTVrAaLA2wQTKCo=" ];
              };

              nix-citizen.starCitizen = {
                enable = true;
                preCommands = ''
                  export DXVK_HUD=compiler;
                  export MANGO_HUD=1;
                '';
                setLimits = true;
              };
            }

            # Home-manager
            home-manager.nixosModules.home-manager

            {
              home-manager = {
                extraSpecialArgs = {
                  inherit inputs;
                };

                useUserPackages = true;

                users.andme = {
                  imports = [
                    ./home-manager/home.nix
                    inputs.zen-browser.homeModules.default
                  ];
                };
              };
            }
          ];
        };
      };
    };
}
