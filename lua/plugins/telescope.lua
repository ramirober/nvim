return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{
			"<leader>b",
			function()
				require("telescope.builtin").buffers()
			end,
			desc = "Buffers",
		},
	},
	config = function()
		require("telescope").setup({
			defaults = {
				path_display = { "filename_first" },
				mappings = {
					n = {
						["dd"] = require("telescope.actions").delete_buffer,
					},
				},
			},
			pickers = {
				buffers = {
					theme = "dropdown",
					previewer = false,
					sort_lastused = true,
					sort_mru = true,
					initial_mode = "insert",
					ignore_current_buffer = true,
					layout_config = {
						width = 0.8,
						height = 0.5,
					},
					borderchars = {
						prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
						results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
						preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
					},
				},
			},
		})
		require("telescope").load_extension("fzf")
	end,
}
