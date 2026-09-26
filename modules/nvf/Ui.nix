{
  vim = {
    ui = {
      smartcolumn = {
        enable = true;
        setupOpts = {
          disabled_filetypes = [
            "help"
            "text"
            "markdown"
            "typst"
          ];
        };
      };
      noice = {
        enable = true;
      };
      borders = {
        enable = true;
        globalStyle = "rounded";
        plugins = {
          which-key.enable = true;
        };
      };

      colorful-menu-nvim.enable = true;
    };

    visuals = {
      rainbow-delimiters.enable = true;
      nvim-web-devicons.enable = true;
      cinnamon-nvim = {
        enable = true;
        setupOpts = {
          keymaps = {
            basic = true;
            extra = true;
          };
          options = {
            mode = "cursor";
          };
        };
      };
    };

    notify.nvim-notify.enable = true;
    statusline.lualine.enable = true;
  };
}
