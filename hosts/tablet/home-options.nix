{
  lib,
  ...
}:
with lib;
{
  moduli.home-manager = {
    direnv.enable = true;
    git.enable = true;
    kitty.enable = true;
    zen.enable = true;
  };
}
