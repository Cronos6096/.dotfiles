{ pkgs, fetchFromPath, ... }:

let
  # Overriding the libratbag package with the local source directory
  libratbag-g502 = pkgs.libratbag.overrideAttrs (oldAttrs: rec {
    pname = "libratbag-g502";
    version = "your-version"; # You can specify the version or leave it empty

    # Using fetchFromPath to point to a local directory
    src = pkgs.fetchFromPath {
      name = "libratbag-g502";
      path = "/home/andme/progetti/libratbag-g502/"; # Local path to your source directory
    };
  });

in
{
  # Adding the custom libratbag-g502 and piper to system packages
  environment.systemPackages = with pkgs; [
    libratbag-g502 # Add your custom libratbag-g502 package
    piper # Add
  ];

  # Ensure the system uses the overridden libratbag-g502 package for the ratbagd service
  services.ratbagd.package = libratbag-g502; # Set the custom fork as the package for ratbagd

  # Enable ratbagd service
  services.ratbagd.enable = true;
}
