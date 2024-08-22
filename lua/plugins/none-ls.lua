return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				require("none-ls.diagnostics.eslint_d"),
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.clang_format,
				null_ls.builtins.formatting.prettierd.with({
					extra_args = {
						"--single-quote",
						"--jsx-single-quote",
						"--trailing-comma" == "es5",
						"--arrow-parens" == "avoid",
						"--tab-width" == 2,
					},
				}),
			},
		})

		vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, {})
	end,
}
