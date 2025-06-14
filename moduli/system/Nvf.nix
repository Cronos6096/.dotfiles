{ pkgs, ... }:
{
  vim = {
    theme = {
      base16-colors = {
        base00 = "#000000";
        base01 = "#383830";
        base02 = "#49483e";
        base03 = "#75715e";
        base04 = "#a59f85";
        base05 = "#f8f8f2";
        base06 = "#f5f4f1";
        base07 = "#f9f8f5";
        base08 = "#f92672";
        base09 = "#fd971f";
        base0A = "#f4bf75";
        base0B = "#a6e22e";
        base0C = "#a1efe4";
        base0D = "#66d9ef";
        base0E = "#ae81ff";
        base0F = "#cc0e33";
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

      zig = {
        enable = true;
        lsp.enable = true;
        treesitter.enable = true;
      };

      lua = {
        enable = true;
        extraDiagnostics.enable = true;
        format.enable = true;
        lsp = {
          enable = true;
        };
        treesitter.enable = true;
      };

      rust.enable = true;
    };
  };
}
