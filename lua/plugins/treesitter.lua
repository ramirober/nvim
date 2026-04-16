return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").setup({
			auto_install = true,
			ensure_installed = {
				"lua",
				"typescript",
				"tsx",
				"javascript",
				"html",
				"css",
				"json",
				"bash",
				"go",
				"java",
				"haskell",
				"c",
				"markdown",
				"markdown_inline",
			},
		})
	end,
}
