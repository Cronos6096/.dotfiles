{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Rpi
    nixos-raspberrypi.url = "github:nvmd/nixos-raspberrypi/main";

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
      nur,
      nixos-raspberrypi,
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
        GiovanGianFranco = nixpkgs.lib.nixosSystem {
          inherit system;
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

            # Nur
            nur.modules.nixos.default

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

        Pi = nixos-raspberrypi.lib.nixosSystem {
          specialArgs = inputs;
          modules = [
            ./moduli/system/Lingua.nix
            ./moduli/system/Stylix.nix

            stylix.nixosModules.stylix

            home-manager.nixosModules.home-manager

            (
              { pkgs, ... }:
              {
                home-manager.extraSpecialArgs = {
                  inherit inputs;
                };

                home-manager.useUserPackages = true;

                home-manager.users.andme = {
                  nixpkgs.config.allowUnfree = true;
                  home.username = "andme";
                  home.homeDirectory = "/home/andme";
                  programs.home-manager.enable = true;
                  home.stateVersion = "25.11";

                  home.packages = with pkgs; [
                    eza
                    bat
                    fzf
                    yazi
                  ];

                  imports = [
                    ./moduli/home-manager/vim/default.nix
                    ./moduli/home-manager/Git.nix
                    ./moduli/home-manager/Terminale.nix
                  ];
                };
              }
            )

            (
              { ... }:
              {
                imports = with nixos-raspberrypi.nixosModules; [
                  raspberry-pi-5.base
                  raspberry-pi-5.bluetooth
                ];
              }
            )
            (
              { ... }:
              {
                networking.hostName = "andme";
                users.users.yourUserName = {
                  initialPassword = "1234";
                  isNormalUser = true;
                  extraGroups = [
                    "wheel"
                  ];
                };

                services.openssh.enable = true;
              }
            )

            (
              { ... }:
              {
                fileSystems = {
                  "/boot/firmware" = {
                    device = "/dev/disk/by-uuid/2175-794E";
                    fsType = "vfat";
                    options = [
                      "noatime"
                      "noauto"
                      "x-systemd.automount"
                      "x-systemd.idle-timeout=1min"
                    ];
                  };
                  "/" = {
                    device = "/dev/disk/by-uuid/44444444-4444-4444-8888-888888888888";
                    fsType = "ext4";
                    options = [ "noatime" ];
                  };
                };
              }
            )
          ];
        };
      };
    };
}
