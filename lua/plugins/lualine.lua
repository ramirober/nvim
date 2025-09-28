return {
	"nvim-lualine/lualine.nvim",
	config = function()
		require("lualine").setup({
			options = {
				theme = "catppuccin",
				-- theme = "auto",
				-- component_separators = { left = "", right = "" },
				-- section_separators = { left = "", right = "" },
				component_separators = { left = "|", right = "|" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = { "neo-tree" },
					winbar = { "neo-tree" },
					tabline = { "neo-tree" },
				},
			},
			disabled_buftypes = { "quickfix", "prompt" },
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", { "diagnostics", update_in_insert = true } },
				lualine_c = {},
				lualine_x = {},
				lualine_y = {
					"filetype",
					{
						"lsp_status",
						icon = "", -- f013
						symbols = {
							spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
							done = "✓",
							separator = " ",
						},
						ignore_lsp = {
							"GitHub Copilot",
							"null-ls",
						},
					},
					"progress",
				},
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
				lualine_b = {
					{
						"filename",
						file_status = true, -- displays file status (readonly status, modified status)
						path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
						symbols = {
							modified = "●", -- Text to show when the file is modified.
							readonly = "", -- Text to show when the file is non-modifiable or readonly.
						},
					},
				},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			inactive_winbar = {
				lualine_a = {},
				lualine_b = {
					{
						"filename",
						file_status = true, -- displays file status (readonly status, modified status)
						symbols = {
							modified = "●", -- Text to show when the file is modified.
							readonly = "", -- Text to show when the file is non-modifiable or readonly.
						},
						path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
					},
				},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {
					{
						"buffers",
						symbols = {
							modified = " ●", -- Text to show when the buffer is modified
							readonly = " ", -- Text to show when the buffer is non-modifiable or readonly
							alternate_file = "#", -- Text to show to identify the alternate file
							directory = "", -- Text to show when the buffer is a directory
						},
						show_filename_only = true,
						mode = 2,
					},
				},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
		})
	end,
}
