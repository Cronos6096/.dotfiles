{ pkgs, ... }:
{
  vim = {
    theme = {
      enable = false;
      name = "onedark";
      style = "darker";
      transparent = true;
    };

    diagnostics = {
      enable = true;
      config = {
        update_in_insert = true;
        virtual_text = true;
      };
    };

    options = {
      tabstop = 2;
      shiftwidth = 2;
      virtualedit = "all";
      expandtab = true;
    };

    keymaps = [
      {
        mode = "n";
        key = " z";
        action = ":lua vim.lsp.buf.format()<CR>";
      }
    ];

    clipboard = {
      enable = true;
    };

    assistant = {
      chatgpt = {
        enable = true;
      };
    };

    ui = {
      smartcolumn.enable = true;
      # noice.enable = true;
      borders.plugins.nvim-cmp.enable = true;
      borders.enable = true;
    };

    statusline.lualine.enable = true;

    syntaxHighlighting = true;

    telescope = {
      enable = true;
      mappings.buffers = " f";
    };

    autocomplete = {
      enableSharedCmpSources = true;
      nvim-cmp = {
        enable = true;
        sourcePlugins = [
          "icon-picker-nvim"
          "telescope"
          "trouble"
        ];
      };
    };

    comments.comment-nvim = {
      enable = true;
    };

    notes.todo-comments = {
      enable = true;
    };

    terminal = {
      toggleterm = {
        enable = true;
        lazygit = {
          enable = true;
          mappings = {
            open = " gg";
          };
        };
        setupOpts.enable_winbar = true;
      };
    };

    utility = {
      yazi-nvim = {
        enable = true;
        mappings = {
          openYaziDir = " -";
          openYazi = " e";
        };
      };
      snacks-nvim.enable = true;
      motion.flash-nvim.enable = true;
    };

    mini = {
      surround.enable = true;
      ai.enable = true;
      basics = {
        enable = true;
        setupOpts = {
          options = {
            basic = true;
            extra_ui = true;
            win_borders = "default";
          };
          mappings = {
            basic = true;
            windows = true;
            move_with_alt = true;
          };
          autocommands = {
            basic = true;
          };
        };
      };
      pairs.enable = true;
      clue.enable = true;
      cursorword.enable = true;
      jump2d.enable = true;
      splitjoin.enable = true;
      trailspace.enable = true;
      icons.enable = true;
    };

    extraPlugins = with pkgs.vimPlugins; {
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

      auto-session = {
        package = auto-session;
        setup = ''
          require("auto-session").setup()
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
            saturation = 0.5,
            italic_comments = true,
            hide_fillchars = true,
            borderless_pickers = true,
            terminal_colors = true,
          })

          vim.cmd("colorscheme cyberdream")
        '';
      };
    };

    undoFile.enable = true;
    hideSearchHighlight = true;
    binds = {
      cheatsheet.enable = true;
      # whichKey.enable = true;
    };

    lsp = {
      enable = true;
      trouble.enable = true;
      lspSignature.enable = true;
    };

    languages = {
      enableTreesitter = true;
      enableFormat = true;
      enableExtraDiagnostics = true;

      markdown = {
        enable = true;
        format.enable = true;
        extensions.render-markdown-nvim.enable = true;
      };

      nix = {
        enable = true;
        lsp = {
          enable = true;
          server = "nixd";
        };
        extraDiagnostics = {
          enable = true;
          types = [
            "deadnix"
            "statix"
          ];
        };
        format = {
          enable = true;
          type = "nixfmt";
        };
        treesitter = {
          enable = true;
        };
      };

      clang = {
        enable = true;
        lsp.enable = true;
      };

      assembly = {
        enable = true;
        lsp.enable = true;
      };

      python = {
        enable = true;
        format = {
          enable = true;
          type = "ruff";
        };
        lsp.enable = true;
        treesitter.enable = true;
      };

      lua = {
        enable = true;
        format.enable = true;
        lsp.enable = true;
        treesitter.enable = true;
      };
    };
  };
}
