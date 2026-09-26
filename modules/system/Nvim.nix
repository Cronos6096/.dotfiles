{
  inputs,
  pkgs,
  ...
}:
{
  environment.systemPackages = [
    (inputs.nvf.lib.neovimConfiguration {
      inherit pkgs;
      modules = [ ../nvf ];
    }).neovim
  ];
}
