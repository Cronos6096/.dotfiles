{
  imports = [
    ./home-manager.nix
    ./neovim.nix
    ./secrets.nix
    ./system.nix
  ];
  nixpkgs.overlays = [
    (_: prev: {
      openldap = prev.openldap.overrideAttrs {
        doCheck = false;
      };
    })
  ];
}
