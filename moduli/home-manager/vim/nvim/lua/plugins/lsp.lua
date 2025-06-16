return {
	{
		"folke/neodev.nvim",
		lazy = false,
		opts = {},
	},

	{
		"neovim/nvim-lspconfig",
		ft = { "lua", "nix" },
		dependencies = {
			"Saghen/blink.cmp",
		},
		config = function()
			local lspconfig = require("lspconfig")
			local blink = require("blink.cmp")
			local caps = blink.get_lsp_capabilities()

			local lua_ls_path = vim.fn.exepath("lua-language-server")
			local lua_main = lua_ls_path:gsub("/bin/lua%-language%-server$", "/libexec/bin/main.lua")

			lspconfig.lua_ls.setup({
				cmd = { lua_ls_path, "-E", lua_main },
				capabilities = caps,
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } },
						workspace = { library = vim.api.nvim_get_runtime_file("", true) },
					},
				},
			})

			local nil_path = vim.fn.exepath("nil")
			lspconfig.nil_ls.setup({
				cmd = { nil_path, "--stdio" },
				filetypes = { "nix" },
				root_dir = lspconfig.util.root_pattern("flake.nix", "default.nix", ".git"),
				capabilities = caps,
			})
		end,
	},

	{
		"Saghen/blink.cmp",
		dependencies = { "rafamadriz/friendly-snippets" },
		version = "1.*",

		opts = {
			completion = { documentation = { auto_show = true } },
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
	},
}
