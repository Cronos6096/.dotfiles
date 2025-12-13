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
