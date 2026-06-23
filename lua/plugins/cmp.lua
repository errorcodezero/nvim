return {
	"saghen/blink.cmp",
	dependencies = { "saghen/blink.lib", "rafamadriz/friendly-snippets" },
	version = "*",
	build = function()
		require("blink.cmp").download({ force = true, tags = "*" }):pwait()
	end,
	opts = {
		keymap = { preset = "super-tab" },

		appearance = {
			nerd_font_variant = "mono",
		},
		completion = { documentation = { auto_show = false } },
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},
		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}
