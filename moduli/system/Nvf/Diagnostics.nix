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
      setupOpts.formatters_by_ft = {
        python = [ "ruff" ];
      };
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
