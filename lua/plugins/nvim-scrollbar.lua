return {
	"petertriho/nvim-scrollbar",
	config = function()
		require("scrollbar").setup({
			set_highlights = true,
			exclude = {
				buftypes = { "terminal" },
				-- A keyed table adds to the default filetypes.
				filetypes = { NeoTree = true },
			},
			providers = {
				cursor = true,
				diagnostic = true,
				gitsigns = true, -- Requires gitsigns
				search = false,
				ale = false,
			},
			marks = {
				GitAdd = { text = { "·" }, priority = 7, highlight = "GitSignsAdd" },
				GitChange = { text = { "·" }, priority = 7, highlight = "GitSignsChange" },
				GitDelete = { text = { "𛲖" }, priority = 7, highlight = "GitSignsDelete" },
			},
			scrollbar = {
				show = true,
				visibility = "all",
				max_lines = false,
				throttle_ms = 100,
				unit = "screenline", -- accounts for closed folds and wrapped lines
				hide_if_all_visible = true,
				events = {
					"BufWinEnter",
					"TabEnter",
					"TermEnter",
					"WinEnter",
					"CmdwinLeave",
					"TextChanged",
					"VimResized",
					"WinScrolled",
				},
				thumb = {
					text = " ",
					blend = 30,
					highlight = "CursorColumn",
					hide_if_all_visible = true,
				},
			},
		})
	end,
}
