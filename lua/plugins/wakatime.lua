if vim.env.WAKATIME_ENABLED then
	return { "wakatime/vim-wakatime", lazy = false }
else
	return {}
end
