local telescope = require("telescope.builtin")

-- Clears highlights after slash searching for something
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set("n", "<leader>w", ":w<enter>", { desc = "[W]rite" })
vim.keymap.set("n", "<leader>q", ":q!<enter>", { desc = "[Q]uit" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[R]ename" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "[G]oto [D]efinition" })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "[G]oto [D]eclaration" })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open Error Float" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open Error Location List" })
vim.keymap.set("n", "<leader>gl", ":ClangdSwitchSourceHeader<enter>")

vim.keymap.set("n", "<leader>sf", telescope.find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>ss", telescope.builtin, { desc = "[S]earch [S]elect Telescope" })
vim.keymap.set("n", "<leader>sw", telescope.grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", telescope.live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", telescope.diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sr", telescope.resume, { desc = "[S]earch [R]esume" })
vim.keymap.set("n", "<leader>s.", telescope.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set("n", "<leader><leader>", telescope.buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>sc", telescope.colorscheme, { desc = "[S]earch [C]olorschemes" })

vim.keymap.set("n", "<leader>/", function()
	-- You can pass additional configuration to Telescope to change the theme, layout, etc.
	telescope.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "[/] Fuzzily search in current buffer" })

-- It's also possible to pass additional configuration options.
--  See `:help telescope.builtin.live_grep()` for information about particular keys
vim.keymap.set("n", "<leader>s/", function()
	telescope.live_grep({
		grep_open_files = true,
		prompt_title = "Live Grep in Open Files",
	})
end, { desc = "[S]earch [/] in Open Files" })

-- Shortcut for searching your Neovim configuration files
vim.keymap.set("n", "<leader>sn", function()
	telescope.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "[S]earch [N]eovim files" })

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.keymap.set("n", "<leader>o", ":Oil<CR>")

local gitsigns = require("gitsigns")

local function gitMap(mode, l, r, opts)
	opts = opts or {}
	opts.buffer = bufnr
	vim.keymap.set(mode, l, r, opts)
end

-- GIT
-- Navigation
gitMap("n", "]c", function()
	if vim.wo.diff then
		vim.cmd.normal({ "]c", bang = true })
	else
		gitsigns.nav_hunk("next")
	end
end, { desc = "Jump to next git [c]hange" })

gitMap("n", "[c", function()
	if vim.wo.diff then
		vim.cmd.normal({ "[c", bang = true })
	else
		gitsigns.nav_hunk("prev")
	end
end, { desc = "Jump to previous git [c]hange" })

-- Actions
-- visual mode
gitMap("v", "<leader>hs", function()
	gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
end, { desc = "git [s]tage hunk" })
gitMap("v", "<leader>hr", function()
	gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
end, { desc = "git [r]eset hunk" })
-- normal mode
gitMap("n", "<leader>hs", gitsigns.stage_hunk, { desc = "git [s]tage hunk" })
gitMap("n", "<leader>hr", gitsigns.reset_hunk, { desc = "git [r]eset hunk" })
gitMap("n", "<leader>hS", gitsigns.stage_buffer, { desc = "git [S]tage buffer" })
gitMap("n", "<leader>hu", gitsigns.stage_hunk, { desc = "git [u]ndo stage hunk" })
gitMap("n", "<leader>hR", gitsigns.reset_buffer, { desc = "git [R]eset buffer" })
gitMap("n", "<leader>hp", gitsigns.preview_hunk, { desc = "git [p]review hunk" })
gitMap("n", "<leader>hb", gitsigns.blame_line, { desc = "git [b]lame line" })
gitMap("n", "<leader>hd", gitsigns.diffthis, { desc = "git [d]iff against index" })
gitMap("n", "<leader>hD", function()
	gitsigns.diffthis("@")
end, { desc = "git [D]iff against last commit" })
-- Toggles
gitMap("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "[T]oggle git show [b]lame line" })
gitMap("n", "<leader>tD", gitsigns.preview_hunk_inline, { desc = "[T]oggle git show [D]eleted" })

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
	callback = function(event)
		vim.keymap.set("n", "<leader>gd", telescope.lsp_definitions, { desc = "[G]oto [D]efinition" })
		vim.keymap.set("n", "<leader>gr", telescope.lsp_references, { desc = "[G]oto [R]eferences" })
		vim.keymap.set("n", "<leader>gI", telescope.lsp_implementations, { desc = "[G]oto [I]mplementation" })
		vim.keymap.set("n", "<leader>gt", telescope.lsp_type_definitions, { desc = "[T]ype Definition" })
		vim.keymap.set("n", "<leader>gs", telescope.lsp_document_symbols, { desc = "Document [S]ymbols" })
		vim.keymap.set("n", "<leader>gws", telescope.lsp_dynamic_workspace_symbols, { desc = "[W]orkspace [S]ymbols" })
		vim.keymap.set("n", "<leader>gth", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
		end)
	end,
})

local harpoon = require("harpoon")

vim.keymap.set("n", "<leader>aa", function()
	harpoon:list():add()
end, { desc = "[A]dd to Harpoon" })
vim.keymap.set("n", "<leader>ae", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "[E]nter quick menu" })

vim.keymap.set("n", "<leader>a1", function()
	harpoon:list():select(1)
end, { desc = "File [1]" })
vim.keymap.set("n", "<leader>a2", function()
	harpoon:list():select(2)
end, { desc = "File [2]" })
vim.keymap.set("n", "<leader>a3", function()
	harpoon:list():select(3)
end, { desc = "File [3]" })
vim.keymap.set("n", "<leader>a4", function()
	harpoon:list():select(4)
end, { desc = "File [4]" })

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<leader>ah", function()
	harpoon:list():prev()
end, { desc = "Previous" })
vim.keymap.set("n", "<leader>al", function()
	harpoon:list():next()
end, { desc = "Next" })

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle [U]ndotree" })
