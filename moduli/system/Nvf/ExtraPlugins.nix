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

      gitsigns = {
        package = gitsigns-nvim;
        setup = ''
          require("gitsigns").setup()
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

      # Snippet
      luasnip = {
        package = luasnip;
        setup = ''
          local ls = require("luasnip")

          vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
          vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true})
          vim.keymap.set({"i", "s"}, "<C-J>", function() ls.jump(-1) end, {silent = true})

          vim.keymap.set({"i", "s"}, "<C-E>", function()
             if ls.choice_active() then
             ls.change_choice(1)
            end
          end, {silent = true})
        '';
      };

      friendly-snippets = {
        package = friendly-snippets;
        setup = ''
          require("luasnip.loaders.from_vscode").lazy_load()
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
              terminal_colors = false,
              cache = false,
          })

          vim.cmd("colorscheme cyberdream")
        '';
      };
    };
  };
}
