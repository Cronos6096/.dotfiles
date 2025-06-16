require("config.options")
require("config.binds")
require("config.lazy")

-- Initialize Mini plugins
require("mini.pairs").setup()
require("mini.starter").setup()
require("mini.diff").setup()
require("mini.splitjoin").setup({
	mappings = {
		toggle = "gS",
	},
	detect = {
		separator = ",",
	},
})
require("mini.basics").setup({
	options = {
		basic = true,
		extra_ui = true,
		win_borders = "default",
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
require("mini.animate").setup()

vim.lsp.enable("lua_ls")

-- ALtri plugin
require("nvim-highlight-colors").setup({})

require("noice").setup({
	lsp = {
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
		},
	},
	presets = {
		bottom_search = false,
		command_palette = true,
		long_message_to_split = true,
		inc_rename = false,
		lsp_doc_border = false,
	},
})

require("codecompanion").setup({
	adapters = {
		openai = function()
			return require("codecompanion.adapters").extend("openai", {
				schema = {
					model = {
						default = "gpt-4.1",
					},
				},
			})
		end,
	},
	strategies = {
		inline = {
			keymaps = {
				accept_change = {
					modes = { n = "ga" },
					description = "Accept the suggested change",
				},
				reject_change = {
					modes = { n = "gr" },
					description = "Reject the suggested change",
				},
			},
		},
	},
})
