{
  pkgs,
  lib,
  ...
}:

let
  Overlay = self: super: rec {
    libratbag = lib.mkForce (
      super.libratbag.overrideAttrs (old: {
        installPhase = ''
          ${old.installPhase}

          mkdir -p $out/share/libratbag
          cp ${./logitech-g502-x-wireless.device} \
             $out/share/libratbag/logitech-g502-x-wireless.device
        '';
      })
    );
  };
in
{
  nixpkgs.overlays = [ Overlay ];
  services.ratbagd.enable = true;
  environment.systemPackages = with pkgs; [
    libratbag
    piper
  ];

  users.users.andme = {
    isNormalUser = true;
    extraGroups = [ "input" ];
  };
}
