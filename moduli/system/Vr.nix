{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    sidequest
    # wlx-overlay-s
  ];
  services.wivrn = {
    enable = true;
    openFirewall = true;
    defaultRuntime = true;
    steam.importOXRRuntimes = true;
    config.enable = true;
  };
}
