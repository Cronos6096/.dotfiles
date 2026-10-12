{
  inputs,
  self,
  ...
}:
let
  inherit (inputs.nixpkgs) lib;

  nixOS =
    {
      system,
      modules,
    }:
    lib.nixosSystem {
      inherit system modules;
      specialArgs = {
        inherit inputs self;
      };
    };

  nixOSRPi =
    {
      system,
      modules,
    }:
    inputs.nixos-raspberrypi.lib.nixosSystem {
      inherit system modules;
      specialArgs = {
        inherit inputs self;
      };
    };

  rpi5Installer = inputs.nixos-raspberrypi.lib.nixosInstaller {
    specialArgs = {
      inherit inputs self;
    };
    modules = [
      inputs.nixos-images.nixosModules.sdimage-installer
      (
        {
          lib,
          modulesPath,
          ...
        }:
        {
          disabledModules = [
            (modulesPath + "/installer/sd-card/sd-image-aarch64-installer.nix")
          ];
          networking.wireless.enable = lib.mkForce false;
        }
      )
      (
        { nixos-raspberrypi, ... }:
        {
          imports = with nixos-raspberrypi.nixosModules; [
            raspberry-pi-5.base
            raspberry-pi-5.page-size-16k
          ];

          users.users.nixos.openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE0eWmYUr3u6FFhpv5Zj6LlcQIm8O4ZSJiZkuOtVM9NL andme@GiovanGianFranco"
          ];
          users.users.root.openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE0eWmYUr3u6FFhpv5Zj6LlcQIm8O4ZSJiZkuOtVM9NL andme@GiovanGianFranco"
          ];
        }
      )
    ];
  };

  systems = [
    "x86_64-linux"
    "aarch64-linux"
  ];

  common = f: "${self}/hosts/common/${f}";

  # Shared by every host (no stylix by default).
  commonModules = [
    "${self}/modules/system"
    inputs.home-manager.nixosModules.home-manager
    (common "home-manager.nix")
    (common "ssh.nix")
  ];

  # Stylix for hosts that support it (GiovanGianFranco, tablet).
  stylixModules = [
    inputs.stylix.nixosModules.stylix
    "${self}/modules/stylix"
  ];

  # rpi5-specific modules without stylix (26.05 incompatibility).
  commonModulesRPi = [
    "${self}/modules/system"
    inputs.home-manager.nixosModules.home-manager
    (common "home-manager.nix")
    (common "ssh.nix")
  ];

  agenixModules = [
    (common "secrets.nix")
    (common "user.nix")
  ];

  pkgsFor =
    system:
    import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

  neovimFor =
    pkgs:
    (inputs.nvf.lib.neovimConfiguration {
      inherit pkgs;
      modules = [ "${self}/modules/nvf" ];
    }).neovim;

  tree = ./.;
in
{
  nixosConfigurations = {
    GiovanGianFranco = nixOS {
      system = "x86_64-linux";
      modules =
        commonModules
        ++ agenixModules
        ++ [
          "${self}/hosts/GiovanGianFranco"
          "${self}/hosts/GiovanGianFranco/home-manager.nix"
          inputs.lanzaboote.nixosModules.lanzaboote
        ]
        ++ stylixModules;
    };

    rpi5 = nixOSRPi {
      system = "aarch64-linux";
      modules =
        commonModulesRPi
        ++ agenixModules
        ++ [
          "${self}/hosts/rpi5"
          inputs.disko.nixosModules.disko
        ];
    };

    tablet = nixOS {
      system = "aarch64-linux";
      modules =
        commonModules
        ++ [
          "${self}/hosts/tablet"
          "${self}/hosts/tablet/home-manager.nix"
        ]
        ++ stylixModules;
    };

    rpi5-installer = rpi5Installer;
  };

  installerImages = {
    rpi5 = rpi5Installer.config.system.build.sdImage;
  };

  packages = lib.genAttrs systems (
    system:
    let
      pkgs = pkgsFor system;
    in
    {
      default = neovimFor pkgs;
      neovim = neovimFor pkgs;
    }
  );

  apps = lib.genAttrs systems (
    system:
    let
      nvim = neovimFor (pkgsFor system);
    in
    {
      default = {
        type = "app";
        program = "${nvim}/bin/nvim";
      };
      neovim = {
        type = "app";
        program = "${nvim}/bin/nvim";
      };
    }
  );

  checks = lib.genAttrs [ "x86_64-linux" ] (
    system:
    let
      pkgs = pkgsFor system;
    in
    {
      formatting = pkgs.runCommand "check-nixfmt-run" { src = tree; } ''
        cd "$src"
        ${pkgs.nixfmt}/bin/nixfmt --check $(find . -name '*.nix')
        mkdir -p "$out"
      '';

      deadnix = pkgs.runCommand "check-deadnix-run" { src = tree; } ''
        cd "$src"
        ${pkgs.deadnix}/bin/deadnix --fail --quiet .
        mkdir -p "$out"
      '';
    }
  );

  formatter = lib.genAttrs systems (system: (pkgsFor system).nixfmt);
}
