{
  programs.nixvim = {
    diagnostics.virtual_text = true;

    plugins = {
      lsp-format = {
        enable = true;
        lspServersToEnable = "all";
      };

      lsp = {
        enable = true;

        inlayHints = true;
        servers.nil_ls = {
          enable = true;
          settings = {
            formatting = {
              command = [ "nixpkgs-fmt" ];
            };
          };
        };

        servers.rust_analyzer = {
          installCargo = true;
          installRustc = true;
        };

        keymaps = {
          silent = true;
          diagnostic = {
            # Navigate in diagnostics
            "<leader>k" = "goto_prev";
            "<leader>j" = "goto_next";
          };

          lspBuf = {
            gd = "definition";
            gD = "references";
            gt = "type_definition";
            gi = "implementation";
            K = "hover";
            "<F2>" = "rename";
          };
        };

        servers = {
          clangd.enable = true;
          texlab.enable = true;
        };
      };
    };
  };
}
