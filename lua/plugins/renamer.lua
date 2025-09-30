return {
	"filipdutescu/renamer.nvim",
	branch = "master", -- specifying the branch
	dependencies = { { "nvim-lua/plenary.nvim" } }, -- dependency for Renamer
	config = function()
		-- Configuring the renamer
		require("renamer").setup({})
		vim.api.nvim_set_keymap(
			"n",
			"<leader>r",
			'<cmd>lua require("renamer").rename()<CR>',
			{ noremap = true, silent = true }
		)
	end,
}
