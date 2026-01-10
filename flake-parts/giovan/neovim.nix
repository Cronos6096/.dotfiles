{
  inputs,
  pkgs,
  ...
}:
{
  environment.systemPackages = [
    (inputs.nvf.lib.neovimConfiguration {
      inherit pkgs;
      modules = [ (import ../../moduli/system/Nvf) ];
    }).neovim
  ];
}
