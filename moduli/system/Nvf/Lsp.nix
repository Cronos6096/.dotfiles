{
  vim = {
    lsp = {
      enable = true;
      trouble.enable = true;
      formatOnSave = true;
      harper-ls.enable = true;
      inlayHints.enable = true;
      lspconfig.enable = true;
    };

    syntaxHighlighting = true;

    treesitter.context.enable = true;
    languages = {
      enableTreesitter = true;
      enableFormat = true;
      enableExtraDiagnostics = true;

      markdown = {
        enable = true;
        format.enable = true;
        extensions.markview-nvim = {
          enable = true;
          setupOpts = {
            typst.enable = false;
          };
        };
      };

      nix = {
        enable = true;
        lsp = {
          servers = [ "nixd" ];
        };
        extraDiagnostics = {
          enable = true;
          types = [
            "deadnix"
            "statix"
          ];
        };
        format = {
          type = [ "nixfmt" ];
        };
      };

      typst = {
        enable = true;
        format.enable = true;
        extensions = {
          typst-preview-nvim.enable = true;
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
        format.enable = true;
      };

      lua = {
        enable = true;
      };
    };
  };
}
