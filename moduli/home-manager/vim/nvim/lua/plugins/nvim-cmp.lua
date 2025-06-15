return {
  {
    'hrsh7th/nvim-cmp',

    event = 'InsertEnter',

    -- All the sources & extras
    dependencies = {
      -- LSP, buffer, path, cmdline, snippets support
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Fuzzy matching engine
      'tzachar/fuzzy.nvim',

      -- Fuzzy path source for cmp
      'tzachar/cmp-fuzzy-path',    -- :contentReference[oaicite:0]{index=0}

      -- Fuzzy buffer source for cmp
      'tzachar/cmp-fuzzy-buffer',  -- :contentReference[oaicite:1]{index=1}

      -- Nerd-Font icons source for cmp
      'chrisgrieser/cmp-nerdfont', -- :contentReference[oaicite:2]{index=2}
    },

    config = function()
      local cmp       = require('cmp')
      local luasnip   = require('luasnip')

      require('luasnip.loaders.from_vscode').lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        -- Mappings (Insert mode)
        mapping = cmp.mapping.preset.insert({
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.close(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),

        -- Configure sources: LSP, snippets, then fuzzy + standard ones
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'fuzzy_path' },
          { name = 'fuzzy_buffer' },
          { name = 'nerdfont' },
        }, {
          { name = 'buffer' },
          { name = 'path' },
        }),

      })

      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'fuzzy_buffer' },
        },
      })

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' },
        }, {
          { name = 'cmdline' },
        }),
      })
    end,
  },

  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = { 'hrsh7th/cmp-nvim-lsp' },
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      require('lspconfig').tsserver.setup { capabilities = capabilities }
    end,
  },
}
