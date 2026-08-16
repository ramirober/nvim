return {
	"stevearc/conform.nvim",
	-- El keymap va en `keys` (no suelto dentro de `opts`, donde se ejecutaba por
	-- efecto colateral al construir la tabla): así lazy carga conform recién al usarlo.
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ lsp_fallback = true })
			end,
			mode = { "n", "v" },
			desc = "Format file",
		},
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			-- ruff reemplaza a black + isort en un solo binario (ya instalado vía mason).
			-- Antes decía `black`, que no está instalado: el formateo de Python fallaba
			-- silenciosamente y caía al lsp_fallback (basedpyright, que no formatea).
			python = { "ruff_organize_imports", "ruff_format" },
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
	},
}
