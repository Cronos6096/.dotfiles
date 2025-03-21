{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    #python314Full
    python313Packages.pip
  ];
}
