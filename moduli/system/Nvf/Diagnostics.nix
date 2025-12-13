{
  vim = {
    diagnostics = {
      enable = true;
      config = {
        update_in_insert = true;
        virtual_text = true;
      };
    };

    formatter.conform-nvim = {
      enable = true;
    };

    spellcheck = {
      enable = true;
      languages = [
        "en"
        "it"
      ];
      vim-dirtytalk.enable = true;
    };
  };
}
