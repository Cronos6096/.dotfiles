{ pkgs, ... }:

{
  home.packages = with pkgs; [ nixvim ];
    programs.nixvim = {
    enable = true;
    opts = {
      number = true;
      shiftwidth = 2;
    };
  };
}
