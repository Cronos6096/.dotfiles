{
  imports = [
    ./autocommands.nix
    ./completion.nix
    ./keymappings.nix
    ./options.nix
    ./plugins
    ./todo.nix
  ];
  programs.nixvim = {
    enable = true;
    nixpkgs.useGlobalPackages = true;
    opts = {
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
    };
    performance = {
      combinePlugins = {
        enable = true;
        standalonePlugins = [
          "hmts.nvim"
          "neorg"
          "nvim-treesitter"
        ];
      };
      byteCompileLua.enable = true;
    };

    luaLoader.enable = true;
  };
}
