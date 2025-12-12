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
        extensions.markview-nvim.enable = true;
      };

      nix = {
        enable = true;
        lsp = {
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
          type = "nixfmt";
        };
      };

      typst = {
        enable = true;
        extensions = {
          typst-concealer.enable = true;
        };
      };

      clang = {
        enable = true;
      };

      assembly = {
        enable = true;
      };

      rust = {
        enable = true;
      };

      python = {
        enable = true;
      };

      lua = {
        enable = true;
      };
    };
  };
}
