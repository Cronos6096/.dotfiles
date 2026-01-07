{
  inputs,
  self,
  ...
}:
{
  perSystem =
    { pkgs, ... }:
    let
      nvfConfig = inputs.nvf.lib.neovimConfiguration {
        inherit pkgs;
        modules = [ (import ../moduli/system/Nvf) ];
      };
      nvfPackage = nvfConfig.neovim;
    in
    {
      packages.default = nvfPackage;
      apps.default = {
        type = "app";
        program = "${nvfPackage}/bin/nvim";
      };
    };

  flake.nixosConfigurations = {
    GiovanGianFranco = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        "${self}/sys/GiovanGianFranco"
        "${self}/nix"
        "${self}/moduli/system/Portals.nix"
        inputs.nur.modules.nixos.default
        inputs.solaar.nixosModules.default
        inputs.stylix.nixosModules.stylix
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager = {
            extraSpecialArgs = { inherit inputs; };
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "backup";
            users.andme = {
              imports = [
                "${self}/home-manager/home.nix"
                inputs.zen-browser.homeModules.default
              ];
            };
          };
        }

        {
          environment.systemPackages = [
            inputs.nix-search-tv.packages.x86_64-linux.default
          ];
        }

        # Secrets
        inputs.agenix.nixosModules.default
        "${self}/secrets.nix"
        {
          environment.systemPackages = [ inputs.agenix.packages.x86_64-linux.default ];
          age.identityPaths = [ "/home/andme/.ssh/id_ed25519" ];
        }

        {
          environment.systemPackages = [
            (inputs.nvf.lib.neovimConfiguration {
              pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
              modules = [ (import "${self}/moduli/system/Nvf") ];
            }).neovim
          ];
        }

        # Kernel
        (
          { pkgs, ... }:
          {
            nixpkgs.overlays = [ inputs.nix-cachyos-kernel.overlays.default ];
            boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-x86_64-v4;
          }
        )

        inputs.lanzaboote.nixosModules.lanzaboote

        (
          { pkgs, lib, ... }:
          {

            environment.systemPackages = [
              pkgs.sbctl
            ];

            boot.loader.systemd-boot.enable = lib.mkForce false;

            boot.lanzaboote = {
              enable = true;
              pkiBundle = "/var/lib/sbctl";
            };
          }
        )
      ];
    };

    rpi5 = inputs.nixos-raspberrypi.lib.nixosSystemFull {
      system = "aarch64-linux";
      specialArgs = {
        inherit inputs;
        inherit (inputs) nixos-raspberrypi;
      };

      modules = [
        "${self}/sys/rpi"
        "${self}/nix/"
        (
          {
            config,
            pkgs,
            lib,
            nixos-raspberrypi,
            ...
          }:
          {
            imports = with nixos-raspberrypi.nixosModules; [
              raspberry-pi-5.base
              raspberry-pi-5.page-size-16k
              raspberry-pi-5.display-vc4
            ];
          }
        )

        inputs.disko.nixosModules.disko

        # Secrets
        inputs.agenix.nixosModules.default
        "${self}/secrets.nix"
        {
          environment.systemPackages = [ inputs.agenix.packages.aarch64-linux.default ];
          age.identityPaths = [ "/home/andme/.ssh/id_ed25519" ];
        }
        {
          boot.tmp.useTmpfs = true;
        }
        {
          environment.systemPackages = [
            (inputs.nvf.lib.neovimConfiguration {
              pkgs = inputs.nixpkgs.legacyPackages.aarch64-linux;
              modules = [ (import "${self}/moduli/system/Nvf") ];
            }).neovim
          ];
        }
        # inputs.home-manager.nixosModules.home-manager
        # {
        #   home-manager = {
        #     extraSpecialArgs = { inherit inputs; };
        #     useGlobalPkgs = true;
        #     useUserPackages = true;
        #     backupFileExtension = "backup";
        #     users.andme = {
        #       imports = [
        #         "${self}/moduli/home-manager/Terminale.nix"
        #       ];
        #       home.stateVersion = "25.11";
        #     };
        #   };
        # }
        (
          {
            config,
            pkgs,
            lib,
            ...
          }:
          let
            kernelBundle = pkgs.linuxAndFirmware.v6_6_31;
          in
          {
            boot = {
              loader.raspberryPi.firmwarePackage = kernelBundle.raspberrypifw;
              loader.raspberryPi.bootloader = "kernel";
              kernelPackages = kernelBundle.linuxPackages_rpi5;
            };

            nixpkgs.overlays = lib.mkAfter [
              (self: super: {
                inherit (kernelBundle) raspberrypiWirelessFirmware;
                inherit (kernelBundle) raspberrypifw;
              })
            ];
          }
        )
      ];
    };
  };
}
