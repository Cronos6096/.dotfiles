{
  vim = {
    keymaps = [
      {
        mode = "n";
        key = " h";
        action = ":lua vim.lsp.buf.format()<CR>";
      }
      {
        key = "<leader>m";
        mode = "n";
        silent = true;
        action = ":make<CR>";
      }
      {
        key = "<leader>y";
        mode = "n";
        silent = true;
        action = ":TypstPreview<CR>";
      }
      {
        key = "<leader>cn";
        mode = "n";
        silent = true;
        action = ":cnext<CR>";
      }
      {
        key = "<leader>cb";
        mode = "n";
        silent = true;
        action = ":cback<CR>";
      }
    ];

    clipboard = {
      enable = true;
    };

    undoFile.enable = true;

    hideSearchHighlight = true;

    binds = {
      cheatsheet.enable = true;
      whichKey.enable = true;
    };
  };
}
