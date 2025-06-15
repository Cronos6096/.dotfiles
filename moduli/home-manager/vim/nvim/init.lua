require("config.options")
require("config.binds")
require("config.lazy")

-- Initialize Mini plugins
require('mini.pairs').setup()
require('mini.starter').setup()
require('mini.diff').setup()
require('mini.basics').setup({
    options = {
        basic = true,
        extra_ui = true,
        win_borders = 'default',
    },
    mappings = {
        basic = true,
        option_toggle_prefix = [[\]],
        windows = true,
        move_with_alt = true,
    },
    autocommands = {
        basic = true,
    },
})
require('mini.animate').setup()

-- ALtri plugin
require('nvim-highlight-colors').setup({})

require("noice").setup({
    lsp = {
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
    },
    presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
    },
})

require('nvim-cursorline').setup {
  cursorline = {
    enable = true,
    timeout = 10000,
    number = false,
  },
  cursorword = {
    enable = true,
    min_length = 3,
    hl = { underline = true },
  }
}
