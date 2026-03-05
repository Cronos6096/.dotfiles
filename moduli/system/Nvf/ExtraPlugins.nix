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

      iron = {
        package = iron-nvim;
        setup = ''
          local iron = require("iron.core")
          local view = require("iron.view")
          local common = require("iron.fts.common")

          iron.setup {
            config = {
              scratch_repl = true,
              repl_definition = {
                sh = {
                  command = {"fish"}
                },
                python = {
                  command = { "python3" },  -- or { "ipython", "--no-autoindent" }
                  format = common.bracketed_paste_python,
                  block_dividers = { "# %%", "#%%" },
                  env = {PYTHON_BASIC_REPL = "1"}
                }
              },
              repl_filetype = function(bufnr, ft)
                return ft
              end,
              dap_integration = true,
              repl_open_cmd = view.split.vertical.botright(0.4)
            },
            keymaps = {
              toggle_repl = "<F4>",
              restart_repl = "<space>rR",
              send_motion = "<space>sc",
              visual_send = "<space>sc",
              send_file = "<F5>",
              send_line = "<space>sl",
              send_paragraph = "<space>sp",
              send_until_cursor = "<space>su",
              send_mark = "<space>sm",
              send_code_block = "<space>sb",
              send_code_block_and_move = "<space>sn",
              mark_motion = "<space>mc",
              mark_visual = "<space>mc",
              remove_mark = "<space>md",
              cr = "<space>s<cr>",
              interrupt = "<space>s<space>",
              exit = "<space>sq",
              clear = "<space>cl",
            },
            highlight = {
              italic = true
            },
            ignore_blank_lines = true,
          }

          vim.keymap.set('n', '<space>rf', '<cmd>IronFocus<cr>')
          vim.keymap.set('n', '<space>rh', '<cmd>IronHide<cr>')
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
