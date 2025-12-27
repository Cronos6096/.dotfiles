{
  imports = [
    ./Diagnostics.nix
    ./Keymaps.nix
    ./Ui.nix
    ./ExtraPlugins.nix
    ./Lsp.nix
  ];

  vim = {
    options = {
      tabstop = 2;
      shiftwidth = 2;
      virtualedit = "all";
      expandtab = true;
    };
    searchCase = "ignore";
    git.enable = true;

    telescope = {
      enable = true;
      mappings.buffers = " f";
    };

    autocomplete = {
      blink-cmp = {
        enable = true;
        friendly-snippets.enable = true;
        setupOpts = {
          keymap.preset = "enter";
          signature.enabled = true;
          completion.documentation = {
            auto_show = true;
            auto_show_delay_ms = 0;
          };
        };
        sourcePlugins = {
          emoji.enable = true;
          ripgrep.enable = true;
          spell.enable = true;
        };
      };
    };

    comments.comment-nvim = {
      enable = true;
    };

    notes.todo-comments = {
      enable = true;
    };

    assistant.supermaven-nvim = {
      enable = true;
    };

    terminal = {
      toggleterm = {
        enable = true;
        mappings.open = " tt";
        lazygit = {
          enable = true;
          mappings.open = " gg";
        };
        setupOpts.enable_winbar = true;
      };
    };

    utility = {
      yazi-nvim = {
        enable = true;
        mappings = {
          openYaziDir = " -";
          openYazi = " e";
        };
      };
      snacks-nvim.enable = true;
      motion.flash-nvim = {
        enable = true;
        mappings = {
          jump = "n";
        };
      };
    };

    mini = {
      surround.enable = true;
      ai.enable = true;
      basics = {
        enable = true;
        setupOpts = {
          options = {
            basic = true;
            extra_ui = true;
            win_borders = "default";
          };
          mappings = {
            basic = true;
            windows = true;
            move_with_alt = true;
          };
          autocommands = {
            basic = true;
          };
        };
      };
      pairs.enable = true;
      clue.enable = true;
      cursorword.enable = true;
      jump2d.enable = true;
      splitjoin.enable = true;
      trailspace.enable = true;
      icons.enable = true;
      starter.enable = true;
    };
  };
}
