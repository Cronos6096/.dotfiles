{ lib, config, ... }:
with lib;
{
  config = mkIf config.moduli.home-manager.niri.enable {
    home.file."/home/andme/.config/niri/config.kdl".source = ../../moduli/wm/niri/config.kdl;
  };
}
