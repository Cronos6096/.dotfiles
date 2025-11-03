{
  vim = {
    keymaps = [
      {
        mode = "n";
        key = " h";
        action = ":lua vim.lsp.buf.format()<CR>";
      }
      {
        mode = "n";
        key = ";";
        silent = true;
        action = ":";
      }
      {
        mode = "n";
        key = ":";
        silent = true;
        action = ";";
      }
      {
        key = "<leader>m";
        mode = "n";
        silent = true;
        action = ":make<CR>";
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
