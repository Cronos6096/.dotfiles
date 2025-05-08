{ pkgs, ... }:
{
  vim = {
    theme = {
      enable = true;
      name = "onedark";
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

    useSystemClipboard = true;

    statusline.lualine.enable = true;

    telescope.enable = true;
    telescope.mappings.buffers = " f";

    autocomplete.nvim-cmp.enable = true;

    comments.comment-nvim = {
      enable = true;
    };

    terminal = {
      toggleterm.enable = true;
      toggleterm.lazygit = {
        enable = true;
      };
      toggleterm.setupOpts.enable_winbar = true;
    };

    dashboard.startify = {
      enable = true;
    };

    filetree.nvimTree = {
      enable = true;
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

      autopairs = {
        package = nvim-autopairs;
        setup = "require('nvim-autopairs').setup {}";
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

    languages = {
      enableLSP = true;
      enableTreesitter = true;

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
      };
      rust.enable = true;
    };
  };
}
