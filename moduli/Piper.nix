{ pkgs, ... }:

let
  libratbag = pkgs.libratbag.overrideAttrs (oldAttrs: rec {
    pname = "libratbag";
    version = "";

    src = pkgs.fetchFromGitHub {
      owner = "Cronos6096";
      repo = "libratbag-g502";
      rev = "39e3e427132e14bd8e544bd035185d5b748d0dcb";
      sha256 = "GUb5RmbB0Q43uiNvgHXUCgvXGTC9pY0xh5vAEpVA2m8=";
    };
  });
in
{
  environment.systemPackages = with pkgs; [
    libratbag
    piper
  ];

  services.ratbagd.package = libratbag;
  services.ratbagd.enable = true;
}
