return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		main = "nvim-treesitter.config",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		opts = {
			ensure_installed = {
				"c",
				"cpp",
				"rust",
				"typescript",
				"javascript",
				"astro",
				"svelte",
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
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["ib"] = { query = "@code_cell.inner", desc = "in block" },
						["ab"] = { query = "@code_cell.outer", desc = "around block" },
					},
				},
				move = {
					enable = true,
					set_jumps = true,
					goto_next_start = {
						["]b"] = { query = "@code_cell.inner", desc = "next block" },
					},
					goto_previous_start = {
						["[b"] = { query = "@code_cell.inner", desc = "previous block" },
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["<leader>sbl"] = "@code_cell.outer",
					},
					swap_previous = {
						["<leader>sbh"] = "@code_cell.outer",
					},
				},
			},
		},
	},
}
