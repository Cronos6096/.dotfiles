{
  vim = {
    diagnostics = {
      enable = true;
      config = {
        update_in_insert = false;
        severity_sort = true;
        virtual_text.spacing = 2;
        float.border = "rounded";
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
    };
  };
}
