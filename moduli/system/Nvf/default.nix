{ pkgs, ... }:
{
  vim = {
    theme = {
      enable = true;
      name = "rose-pine";
      style = "main";
      transparent = true;
    };

    options = {
      tabstop = 2;
      shiftwidth = 2;
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
      avante-nvim = {
        enable = true;
        setupOpts.behaviour.enable_cursor_planning_mode = true;
      };
    };

    ui = {
      smartcolumn.enable = true;
      noice.enable = true;
    };

    statusline.lualine.enable = true;

    syntaxHighlighting = true;

    telescope = {
      enable = true;
      mappings.buffers = " f";
    };

    autocomplete.nvim-cmp = {
      enable = true;
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
          openYaziDir = " e";
        };
      };
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
    };

    undoFile.enable = true;
    hideSearchHighlight = true;
    binds = {
      cheatsheet.enable = true;
      whichKey.enable = true;
    };

    lsp = {
      enable = true;
      trouble.enable = true;
    };

    languages = {
      enableTreesitter = true;
      enableFormat = true;

      markdown = {
        enable = true;
        format.enable = true;
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

      python = {
        enable = true;
        format = {
          enable = true;
          type = "ruff";
        };
        lsp.enable = true;
        treesitter.enable = true;
      };
    };
  };
}
