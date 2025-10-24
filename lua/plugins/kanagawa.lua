return {
	"rebelot/kanagawa.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("kanagawa").setup({
			compile = true,
			undercurl = true,
			commentStyle = { italic = true },
			functionStyle = { bold = true },
			keywordStyle = { italic = true },
			statementStyle = { bold = true },
			typeStyle = { italic = true },
			variablebuiltinStyle = { italic = true },
			specialReturnTypeStyle = { italic = true },
			theme = "dragon",
			background = {
				dark = "dragon",
				light = "lotus",
			},
		})
		-- vim.cmd("colorscheme kanagawa")
	end,
}
