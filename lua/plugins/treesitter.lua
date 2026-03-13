return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		main = "nvim-treesitter.config",
		opts = {
			ensure_installed = {
				"c",
				"cpp",
				"rust",
				"typescript",
				"javascript",
				"html",
				"css",
				"markdown",
				"lua",
				"luadoc",
			},
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = { "ruby" },
			},
			indent = { enable = true, disable = { "ruby" } },
		},
	},
}
