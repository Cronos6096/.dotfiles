{ pkgs, ... }:
{
  programs.gcc.enable = true;
  environment.systemPackages = with pkgs; [
  ];
}
