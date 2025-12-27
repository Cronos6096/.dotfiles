{ pkgs, ... }:
{
  vim = {
    extraPlugins = with pkgs.vimPlugins; {
      plenary = {
        package = plenary-nvim;
        setup = ''
          require("plenary")
        '';
      };

      colorizer = {
        package = nvim-colorizer-lua;
        setup = ''
          require("colorizer").setup()
        '';
      };

      git-blame = {
        package = git-blame-nvim;
        setup = ''
          require("gitblame")
        '';
      };

      undotree = {
        package = undotree;
        setup = ''
          vim.keymap.set("n", " u", vim.cmd.UndotreeToggle)
        '';
      };

      cyberdream = {
        package = cyberdream-nvim;
        setup = ''
            require("cyberdream").setup({
              variant = "dark",
              transparent = true,
              saturation = 0.75,
              italic_comments = true,
              borderless_pickers = false,
              terminal_colors = true,
              cache = false,
          })

          vim.cmd("colorscheme cyberdream")
        '';
      };
    };
  };
}
