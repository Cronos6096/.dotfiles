{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Segreti
    sops-nix = {
      url = "github:mic92/sops-nix";
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

    # Mangowm
    mango = {
      url = "github:DreamMaoMao/mango";
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

    # Neovim
    nvf.url = "github:notashelf/nvf";

    # Winboat
    winboat.url = "github:TibixDev/winboat";

    # Starcitizen
    # nix-citizen.url = "github:LovingMelody/nix-citizen";
  };

  outputs =
    {
      chaotic,
      home-manager,
      # nix-citizen,
      nix-search-tv,
      nixpkgs,
      nur,
      nvf,
      self,
      solaar,
      sops-nix,
      stylix,
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

            {
              nixpkgs.config.platforms = [ "x86_64-linux" ];
            }

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

            # sops
            sops-nix.nixosModules.sops
            ./secrets

            # Chaotic
            chaotic.nixosModules.default

            # Integrazione di solaar
            solaar.nixosModules.default

            # Modulo di Stylix NixOS
            stylix.nixosModules.stylix

            # Starcitizen
            # nix-citizen.nixosModules.StarCitizen
            # {
            #   nix.settings = {
            #     substituters = [ "https://nix-citizen.cachix.org" ];
            #     trusted-public-keys = [ "nix-citizen.cachix.org-1:lPMkWc2X8XD4/7YPEEwXKKBg+SVbYTVrAaLA2wQTKCo=" ];
            #   };
            #
            #   nix-citizen.starCitizen = {
            #     enable = true;
            #     preCommands = ''
            #       export DXVK_HUD=compiler;
            #       export MANGO_HUD=1;
            #     '';
            #     setLimits = true;
            #   };
            # }

            # Mangowm
            inputs.mango.nixosModules.mango
            {
              programs.mango.enable = true;
              services.seatd = {
                enable = true;
                user = "andme";
              };
            }

            # Home-manager
            home-manager.nixosModules.home-manager

            {
              home-manager = {
                extraSpecialArgs = {
                  inherit inputs;
                };

                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "backup";

                users.andme = {
                  imports = [
                    ./home-manager/home.nix
                    inputs.zen-browser.homeModules.default
                    # inputs.mango.hmModules.mango
                  ];
                };
              };
            }
          ];
        };
      };
    };
}
