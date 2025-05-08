{ pkgs, ... }:
{
  vim = {
    theme = {
      enable = true;
      name = "onedark";
    };

    statusline.lualine.enable = true;

    telescope.enable = true;

    autocomplete.nvim-cmp.enable = true;

    comments.comment-nvim = {
      enable = true;
    };

    dashboard.startify = {
      enable = true;
    };

    filetree.neo-tree = {
      enable = true;
      setupOpts.hijack_cursor = true;
    };

    extraPlugins = with pkgs.vimPlugins; {
      aerial = {
        package = aerial-nvim;
        setup = "require('aerial').setup {}";
      };

      harpoon = {
        package = harpoon;
        setup = "require('harpoon').setup {}";
        after = [ "aerial" ]; # place harpoon configuration after aerial
      };
    };

    languages = {
      enableLSP = true;
      enableTreesitter = true;
      nix.enable = true;
      rust.enable = true;
    };
  };
}
