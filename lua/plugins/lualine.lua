return {
	"nvim-lualine/lualine.nvim",
	config = function()
		require("lualine").setup({
			options = {
				theme = "auto",
				-- component_separators = { left = "", right = "" },
				-- section_separators = { left = "", right = "" },
				component_separators = { left = "|", right = "|" },
				section_separators = { left = "", right = "" },
			},
			extensions = { "neo-tree" },
			disabled_filetypes = { "packer", "NVimTree" },
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", { "diagnostics", update_in_insert = true } },
				lualine_c = {},
				lualine_x = {},
				lualine_y = { "filetype", "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", { "diagnostics", update_in_insert = true } },
				lualine_c = {},
				lualine_x = {},
				lualine_y = { "filetype", "progress" },
				lualine_z = { "location" },
			},
			winbar = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {
					{
						"buffers",
						symbols = {
							modified = " ●", -- Text to show when the buffer is modified
							alternate_file = "#", -- Text to show to identify the alternate file
							directory = "", -- Text to show when the buffer is a directory
						},
						show_filename_only = false,
					},
				},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			inactive_winbar = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {
					{
						"buffers",
						symbols = {
							modified = " ●", -- Text to show when the buffer is modified
							alternate_file = "#", -- Text to show to identify the alternate file
							directory = "", -- Text to show when the buffer is a directory
						},
						show_filename_only = false,
					},
				},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
		})
	end,
}
