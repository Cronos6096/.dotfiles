{
  vim = {
    keymaps = [
      {
        key = "<leader>y";
        mode = "n";
        desc = "Toggle Typst preview";
        action = "<cmd>TypstPreview<cr>";
      }
      {
        key = "<leader>cn";
        mode = "n";
        desc = "Next quickfix entry";
        action = "<cmd>cnext<cr>";
      }
      {
        key = "<leader>cb";
        mode = "n";
        desc = "Previous quickfix entry";
        action = "<cmd>cback<cr>";
      }
      {
        key = "<leader>u";
        mode = "n";
        desc = "Toggle undo tree";
        action = "<cmd>UndotreeToggle<cr>";
      }
      {
        key = "<leader>du";
        mode = "n";
        desc = "Toggle DAP view";
        action = "<cmd>DapViewToggle<cr>";
      }
    ];

    undoFile.enable = true;

    hideSearchHighlight = true;

    binds = {
      cheatsheet.enable = true;
      whichKey.enable = true;
    };
  };
}
