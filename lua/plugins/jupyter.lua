local venv_path = vim.fn.expand("~/.virtualenvs/neovim")

local packages = {
	"pynvim",
	"jupyter_client",
	"jupytext",
	"ipykernel",
	"cairosvg",
	"plotly",
	"kaleido",
	"pnglatex",
	"pyperclip",
}

local function ensure_venv()
	if vim.fn.isdirectory(venv_path) == 0 then
		vim.notify("molten-nvim: creating Neovim Python venv at " .. venv_path, vim.log.levels.INFO)
		vim.fn.mkdir(vim.fn.expand("~/.virtualenvs"), "p")
		vim.fn.system({ "python3", "-m", "venv", venv_path })
		vim.fn.system(vim.list_extend({ venv_path .. "/bin/pip", "install" }, packages))
	end
end

return {
	{
		"benlubas/molten-nvim",
		version = "^1.0.0",
		dependencies = { "3rd/image.nvim" },
		build = function()
			vim.fn.mkdir(vim.fn.expand("~/.virtualenvs"), "p")
			if vim.fn.isdirectory(venv_path) == 0 then
				vim.fn.system({ "python3", "-m", "venv", venv_path })
			end
			vim.fn.system(vim.list_extend({ venv_path .. "/bin/pip", "install", "--upgrade" }, packages))
			vim.cmd("UpdateRemotePlugins")
		end,
		init = function()
			ensure_venv()
			vim.g.python3_host_prog = venv_path .. "/bin/python3"
			vim.env.PATH = venv_path .. "/bin:" .. vim.env.PATH
			vim.g.molten_image_provider = "image.nvim"
			vim.g.molten_output_win_max_height = 20
			vim.g.molten_auto_open_output = false
			vim.g.molten_wrap_output = true
			vim.g.molten_virt_text_output = true
			vim.g.molten_virt_lines_off_by_1 = true
		end,
		config = function()
			local augroup = vim.api.nvim_create_augroup("molten_notebook", { clear = true })

			-- Auto-init molten and import outputs when opening a notebook
			vim.api.nvim_create_autocmd("BufAdd", {
				group = augroup,
				pattern = { "*.ipynb" },
				callback = function(e)
					if string.match(e.file, ".ipynb") then
						vim.schedule(function()
							local ok = pcall(vim.cmd, "MoltenInit python3")
							if ok then
								pcall(vim.cmd, "MoltenImportOutput")
							end
						end)
					end
				end,
				desc = "auto init molten and import outputs for notebooks",
			})

			-- Create a blank notebook with Python kernelspec
			vim.api.nvim_create_user_command("NewNotebook", function(opts)
				local fname = opts.args ~= "" and opts.args or "notebook.ipynb"
				local template = vim.json.encode({
					cells = {},
					metadata = {
						kernelspec = {
							display_name = "Python 3",
							language = "python",
							name = "python3",
						},
						language_info = { name = "python" },
					},
					nbformat = 4,
					nbformat_minor = 5,
				})
				local f = io.open(fname, "w")
				if f then
					f:write(template)
					f:close()
					vim.cmd("edit " .. vim.fn.fnameescape(fname))
				else
					vim.notify("NewNotebook: failed to create " .. fname, vim.log.levels.ERROR)
				end
			end, { nargs = "?", desc = "Create a new blank Jupyter notebook" })
		end,
	},
	{
		"3rd/image.nvim",
		opts = {
			backend = "kitty",
			max_width = 100,
			max_height = 12,
			max_height_window_percentage = math.huge,
			max_width_window_percentage = math.huge,
			window_overlap_clear_enabled = true,
			window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
		},
	},
	{
		"GCBallesteros/jupytext.nvim",
		opts = {
			style = "markdown",
			output_extension = "md",
			force_ft = "markdown",
		},
	},
}
