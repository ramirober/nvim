return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		vim.keymap.set("n", "<leader>e", ":Neotree source=filesystem toggle position=left<CR>")
		require("neo-tree").setup({
			filesystem = {
				filtered_items = {
					visible = true,
				},
			},
			close_if_last_window = false,
			source_selector = {
				winbar = true,
			},
			window = {
				width = 38,
			},
		})
	end,
}
