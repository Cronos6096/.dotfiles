let
  nixvim = import (
    builtins.fetchGit {
      url = "https://github.com/nix-community/nixvim";
      ref = "main";
    }
  );
in
{
   imports = [
    nixvim.homeManagerModules.nixvim
    # ./autocommands.nix
    # ./completion.nix
    # ./keymappings.nix
    # ./options.nix
    # ./plugins
    # ./todo.nix
  ];
  
  programs.nixvim = {
    enable = true;
    opts = {
      number = true;
      shiftwidth = 2;
    };
  };
}
