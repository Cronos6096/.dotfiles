return {
	{
		"scottmckendry/cyberdream.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("cyberdream").setup({
				variant = "auto",
				transparent = true,
				italic_comments = true,
				hide_fillchars = true,
				cache = true,
				borderless_pickers = true,
			})
			vim.cmd("colorscheme cyberdream")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = false,
		opts = {
			theme = "auto",
		},
	},
}
