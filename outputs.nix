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

  systems = [ "x86_64-linux" ];

  common = f: "${self}/hosts/common/${f}";

  commonModules = [
    "${self}/modules/system"
    inputs.home-manager.nixosModules.home-manager
    (common "home-manager.nix")
    (common "ssh.nix")
  ];

  stylixModules = [
    inputs.stylix.nixosModules.stylix
    "${self}/modules/stylix"
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

    server = nixOS {
      system = "x86_64-linux";
      modules =
        commonModules
        ++ agenixModules
        ++ [
          "${self}/hosts/server"
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
