return {
	"catppuccin/nvim",
	lazy = false,
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			-- compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
			flavour = "mocha",
			background = { -- :h background
				light = "latte",
				dark = "mocha",
			},
			transparent_background = true,
			term_colors = true,
			show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
			dim_inactive = {
				enabled = true, -- dims the background color of inactive window
				shade = "dark",
				percentage = 0.15, -- percentage of the shade to apply to the inactive window
			},
			no_italic = true, -- Force no italic
			no_bold = false, -- Force no bold
			no_underline = false, -- Force no underline
			styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
				comments = {}, -- Change the style of comments
				conditionals = {},
				loops = {},
				functions = {},
				keywords = {},
				strings = {},
				variables = {},
				numbers = {},
				booleans = {},
				properties = {},
				types = {},
				operators = {},
				-- miscs = {}, -- Uncomment to turn off hard-coded styles
			},
			color_overrides = {},
			custom_highlights = {},
			default_integrations = true,
			integrations = {
				cmp = true,
				gitsigns = true,
				nvimtree = true,
				neotree = true,
				treesitter = true,
				notify = false,
				telescope = {
					enabled = true,
					style = "nvchad"
				},
				illuminate = {
					enabled = true,
					lsp = false,
				},
				mini = {
					enabled = true,
					indentscope_color = "",
				},
				-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
			},
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}
