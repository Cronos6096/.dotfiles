{ pkgs, ... }:
{
  vim = {
    theme = {
      enable = true;
      transparent = true;
      name = "base16";
      base16-colors = {
        base00 = "#0F1419";
        base01 = "#131721";
        base02 = "#272D38";
        base03 = "#3E4B59";
        base04 = "#BFBDB6";
        base05 = "#E6E1CF";
        base06 = "#E6E1CF";
        base07 = "#F3F4F5";
        base08 = "#F07178";
        base09 = "#FF8F40";
        base0A = "#FFB454";
        base0B = "#B8CC52";
        base0C = "#95E6CB";
        base0D = "#59C2FF";
        base0E = "#D2A6FF";
        base0F = "#E6B673";
      };
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
      codecompanion-nvim.enable = true;
      copilot.enable = true;
    };

    ui = {
      smartcolumn.enable = true;
    };

    statusline.lualine.enable = true;

    syntaxHighlighting = true;

    telescope.enable = true;
    telescope.mappings.buffers = " f";

    autocomplete.blink-cmp = {
      enable = true;
      friendly-snippets.enable = true;
      setupOpts.cmdline.keymap.preset = "enter";
      sourcePlugins.ripgrep.enable = true;
      sourcePlugins.emoji.enable = true;
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
            open = " g";
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

    filetree.nvimTree = {
      enable = true;
      mappings = {
        toggle = "<leader>t";
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
    };

    hideSearchHighlight = true;

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
