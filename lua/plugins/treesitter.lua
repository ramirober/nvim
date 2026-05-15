return {
	"neovim-treesitter/nvim-treesitter",
	dependencies = { "neovim-treesitter/treesitter-parser-registry" },
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local nts = require("nvim-treesitter")
		nts.setup({})

		local parsers = {
			"lua",
			"typescript",
			"tsx",
			"jsx",
			"javascript",
			"html",
			"html_tags",
			"css",
			"json",
			"bash",
			"go",
			"java",
			"haskell",
			"c",
			"markdown",
			"markdown_inline",
		}

		local installed = nts.get_installed and nts.get_installed() or {}
		local missing = vim.tbl_filter(function(p)
			return not vim.tbl_contains(installed, p)
		end, parsers)
		if #missing > 0 then
			nts.install(missing)
		end

		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"lua",
				"typescript",
				"typescriptreact",
				"javascript",
				"javascriptreact",
				"html",
				"css",
				"json",
				"bash",
				"sh",
				"go",
				"java",
				"haskell",
				"c",
				"markdown",
			},
			callback = function(args)
				pcall(vim.treesitter.start, args.buf)
				vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}
