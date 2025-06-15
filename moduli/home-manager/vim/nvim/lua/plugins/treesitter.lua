return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            local configs = require("nvim-treesitter.configs")
            configs.setup({
                highlight = {
                    enable = true,
                },
                indent = { enable = true },
                autotag = { enable = true },
                ensure_installed = {
                    "json",
                    "yaml",
                    "css",
                    "markdown",
                    "lua",
                    "c",
                    "gitignore",
                    "nix",
                    "python",
                    "rust",
                },
                auto_install = false,
            })
        end
    }
}
