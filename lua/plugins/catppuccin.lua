return {
	"catppuccin/nvim",
	lazy = false,
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha",
			transparent_background = true,
			term_colors = true,
			styles = {
				comments = { "italic" },
				miscs = {},
			},
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}
