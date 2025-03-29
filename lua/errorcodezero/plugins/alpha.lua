return {
	"goolord/alpha-nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local dashboard = require("alpha.themes.dashboard")
		local headers = {
			{
				[[=================     ===============     ===============   ========  ========]],
				[[\\ . . . . . . .\\   //. . . . . . .\\   //. . . . . . .\\  \\. . .\\// . . //]],
				[[||. . ._____. . .|| ||. . ._____. . .|| ||. . ._____. . .|| || . . .\/ . . .||]],
				[[|| . .||   ||. . || || . .||   ||. . || || . .||   ||. . || ||. . . . . . . ||]],
				[[||. . ||   || . .|| ||. . ||   || . .|| ||. . ||   || . .|| || . | . . . . .||]],
				[[|| . .||   ||. _-|| ||-_ .||   ||. . || || . .||   ||. _-|| ||-_.|\ . . . . ||]],
				[[||. . ||   ||-'  || ||  `-||   || . .|| ||. . ||   ||-'  || ||  `|\_ . .|. .||]],
				[[|| . _||   ||    || ||    ||   ||_ . || || . _||   ||    || ||   |\ `-_/| . ||]],
				[[||_-' ||  .|/    || ||    \|.  || `-_|| ||_-' ||  .|/    || ||   | \  / |-_.||]],
				[[||    ||_-'      || ||      `-_||    || ||    ||_-'      || ||   | \  / |  `||]],
				[[||    `'         || ||         `'    || ||    `'         || ||   | \  / |   ||]],
				[[||            .===' `===.         .==='.`===.         .===' /==. |  \/  |   ||]],
				[[||         .=='   \_|-_ `===. .==='   _|_   `===. .===' _-|/   `==  \/  |   ||]],
				[[||      .=='    _-'    `-_  `='    _-'   `-_    `='  _-'   `-_  /|  \/  |   ||]],
				[[||   .=='    _-'          `-__\._-'         `-_./__-'         `' |. /|  |   ||]],
				[[||.=='    _-'                                                     `' |  /==.||]],
				[[=='    _-'                                                            \/   `==]],
				[[\   _-'                                                                `-_   /]],
				[[`''                                                                      ``']],
			},
			{
				"███████╗██████╗░██████╗░░█████╗░██████╗░░█████╗░░█████╗░██████╗░███████╗░█████╗░",
				"██╔════╝██╔══██╗██╔══██╗██╔══██╗██╔══██╗██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔══██╗",
				"█████╗░░██████╔╝██████╔╝██║░░██║██████╔╝██║░░╚═╝██║░░██║██║░░██║█████╗░░██║░░██║",
				"██╔══╝░░██╔══██╗██╔══██╗██║░░██║██╔══██╗██║░░██╗██║░░██║██║░░██║██╔══╝░░██║░░██║",
				"███████╗██║░░██║██║░░██║╚█████╔╝██║░░██║╚█████╔╝╚█████╔╝██████╔╝███████╗╚█████╔╝",
				"╚══════╝╚═╝░░╚═╝╚═╝░░╚═╝░╚════╝░╚═╝░░╚═╝░╚════╝░░╚════╝░╚═════╝░╚══════╝░╚════╝░",
			},
		}
		local quotes = {
			"Object oriented programs are offered as alternatives to correct ones - Dijkstra",
			"Java: Write once, debug everywhere",
			"Nothing is more permanent than a temporary solution.",
			"There are 2 hard problems in computer science: cache invalidation, naming things, and off-by-1 errors.",
			"Rise and shine Mr. Freeman",
			"Postfix vs Prefix what is the difference?",
			"Now runs on a smart toaster near you!",
		}
		dashboard.section.buttons.val = {
			dashboard.button("1", "󰈔 Open File", ":Telescope find_files<enter>"),
			dashboard.button("2", "󰨭 Live Grep", ":Telescope live_grep<enter>"),
			dashboard.button("3", "󱊈 Plugins", ":Lazy<enter>"),
			dashboard.button("4", "󰒋 LSP Servers", ":Mason<enter>"),
			dashboard.button("5", "󰅖 Quit", ":q!<enter>"),
		}
		math.randomseed(os.time())
		dashboard.section.footer.val = quotes[math.random(#quotes)]
		dashboard.section.header.val = headers[math.random(#headers)]
		require("alpha").setup(dashboard.config)
	end,
}
