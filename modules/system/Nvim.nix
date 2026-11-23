{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.moduli.system.nvim.enable {
    environment.systemPackages = [
      (inputs.nvf.lib.neovimConfiguration {
        inherit pkgs;
        modules = [ ../nvf ];
      }).neovim
    ];
  };
}
