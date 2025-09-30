return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "black" },
			javascript = { "prettierd" },
			javascriptreact = { "prettierd" },
			typescript = { "prettierd" },
			typescriptreact = { "prettierd" },
			json = { "prettierd" },
			markdown = { "prettierd" },
			html = { "prettierd" },
			css = { "prettierd" },
			scss = { "prettierd" },
			yaml = { "prettierd" },
			go = { "gofmt" },
			c = { "clang_format" },
			cpp = { "clang_format" },
			sql = { "sql_formatter" },
		},
		vim.keymap.set("n", "<leader>f", function()
			require("conform").format({ lsp_fallback = true })
		end, { desc = "Format file" }),
	},
}
