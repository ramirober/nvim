return {
	"catppuccin/nvim",
	lazy = false,
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			-- compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
			auto_integrations = true,
			flavour = "mocha",
			background = { -- :h background
				light = "latte",
				dark = "mocha",
			},
			transparent_background = false,
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
				comments = {
					"italic",
				}, -- Change the style of comments
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
			custom_highlights = function(colors)
				return {
					-- React/JSX components - link to Type highlighting (yellow)
					["@tag.tsx"] = { link = "@type" },
					["@tag.jsx"] = { link = "@type" },
					["@tag.attribute.tsx"] = { link = "@boolean" },
					["@tag.attribute.jsx"] = { link = "@boolean" },
				}
			end,
			default_integrations = true,
			integrations = {
				mason = true,
				blink_cmp = {
					style = "bordered",
				},
				gitsigns = true,
				nvimtree = true,
				neotree = true,
				treesitter = true,
				indent_blankline = {
					enabled = true,
				},
				telescope = {
					enabled = true,
					-- style = "nvchad"
				},
				illuminate = {
					enabled = true,
					lsp = false,
				},
				-- More plugins integrations: https://github.com/catppuccin/nvim#integrations
			},
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}
