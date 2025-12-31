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
        inputs.sops-nix.nixosModules.sops
        "${self}/secrets"
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
            boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;

            nix.settings.substituters = [
            ];
            nix.settings.trusted-public-keys = [
            ];
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
  };
}
