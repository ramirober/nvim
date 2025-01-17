return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({
			window = {},
			filesystem = {},
			close_if_last_window = true,
			source_selector = {
				winbar = true,
			},
			enable_diagnostics = true,
			enable_git_status = true,
		})
		vim.keymap.set("n", "<leader>e", ":Neotree action=focus position=float reveal<CR>")
	end,
}
