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
      borders.plugins = {
        which-key.enable = true;
      };
      borders.enable = true;
      borders.globalStyle = "rounded";
      breadcrumbs.enable = true;
      colorful-menu-nvim.enable = true;
    };

    statusline.lualine.enable = true;
  };
}
