{
  vim = {
    lsp = {
      enable = true;
      trouble.enable = true;
      lspSignature.enable = true;
    };

    syntaxHighlighting = true;

    languages = {
      enableTreesitter = true;
      enableFormat = true;
      enableExtraDiagnostics = true;

      markdown = {
        enable = true;
        format.enable = true;
        extensions.render-markdown-nvim.enable = true;
      };

      nix = {
        enable = true;
        lsp = {
          enable = true;
          server = "nixd";
        };
        extraDiagnostics = {
          enable = true;
          types = [
            "deadnix"
            "statix"
          ];
        };
        format = {
          enable = true;
          type = "nixfmt";
        };
        treesitter = {
          enable = true;
        };
      };

      clang = {
        enable = true;
        lsp.enable = true;
      };

      assembly = {
        enable = true;
        lsp.enable = true;
      };

      python = {
        enable = true;
        format = {
          enable = true;
          type = "ruff";
        };
        lsp = {
          enable = true;
        };
        treesitter.enable = true;
      };

      lua = {
        enable = true;
        format.enable = true;
        lsp.enable = true;
        treesitter.enable = true;
      };
    };
  };
}
