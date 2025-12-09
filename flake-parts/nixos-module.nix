{
  inputs,
  lib,
  self,
  ...
}:
{
  flake.nixosConfigurations = {
    GiovanGianFranco = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        "${self}/sys/GiovanGianFranco"
        "${self}/nix"
        "${self}/moduli/system/Portals.nix"
        inputs.nur.modules.nixos.default
        inputs.sops-nix.nixosModules.sops
        "${self}/secrets"
        inputs.chaotic.nixosModules.default
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
            (inputs.nvf.lib.neovimConfiguration {
              pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
              modules = [ (import "${self}/moduli/system/Nvf") ];
            }).neovim
          ];
        }

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
  };
}
