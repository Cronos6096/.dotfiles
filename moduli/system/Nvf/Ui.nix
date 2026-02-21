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

    statusline.lualine.enable = true;
    visuals.rainbow-delimiters.enable = true;
  };
}
