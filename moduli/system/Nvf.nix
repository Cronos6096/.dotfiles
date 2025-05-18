{ pkgs, ... }:
{
  vim = {
    theme = {
      base16-colors = {
        base00 = "#1d2021";
        base01 = "#383c3e";
        base02 = "#53585b";
        base03 = "#6f7579";
        base04 = "#cdcdcd";
        base05 = "#d5d5d5";
        base06 = "#dddddd";
        base07 = "#e5e5e5";
        base08 = "#d72638";
        base09 = "#eb8413";
        base0A = "#f19d1a";
        base0B = "#88b92d";
        base0C = "#1ba595";
        base0D = "#1e8bac";
        base0E = "#be4264";
        base0F = "#c85e0d";
      };
      enable = true;
      name = "base16";
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

    statusline.lualine.enable = true;

    syntaxHighlighting = true;

    telescope.enable = true;
    telescope.mappings.buffers = " f";

    autocomplete.nvim-cmp.enable = true;

    autopairs.nvim-autopairs.enable = true;

    comments.comment-nvim = {
      enable = true;
    };

    terminal = {
      toggleterm = {
        enable = true;
        lazygit = {
          enable = true;
        };
        setupOpts.enable_winbar = true;
      };
    };

    dashboard.startify = {
      enable = true;
    };

    assistant.codecompanion-nvim = {
      enable = true;
      setupOpts = {
        display.chat.start_in_insert_mode = true;
        display.diff.enabled = true;
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

    extraPlugins = with pkgs.vimPlugins; {
      aerial = {
        package = aerial-nvim;
        setup = "require('aerial').setup {}";
      };

      harpoon = {
        package = harpoon;
        setup = "require('harpoon').setup {}";
        after = [ "aerial" ];
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

      notify = {
        package = nvim-notify;
        setup = ''
          vim.notify = require("notify")
        '';
      };
    };

    hideSearchHighlight = true;

    lsp.enable = true;

    languages = {
      enableTreesitter = true;

      markdown = {
        enable = true;
        format.enable = true;
      };

      nix = {
        enable = true;
        lsp = {
          enable = true;
          server = "nil";
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

      rust.enable = true;
    };
  };
}
