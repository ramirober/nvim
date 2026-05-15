return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup({
				ui = {
					border = "rounded",
				},
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"ts_ls",
					"html",
					"cssls",
					"clangd",
					"jdtls",
					"gopls",
					"hls",
					"bashls",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			-- local capabilities = require("cmp_nvim_lsp").default_capabilities()

			virtual_text = false
			local function organize_imports()
				if #vim.lsp.get_clients({ bufnr = 0, name = "ts_ls" }) > 0 then
					vim.lsp.buf.execute_command({
						command = "_typescript.organizeImports",
						arguments = { vim.api.nvim_buf_get_name(0) },
					})
				else
					vim.lsp.buf.code_action({
						context = { only = { "source.organizeImports" }, diagnostics = {} },
						apply = true,
					})
				end
			end
			vim.lsp.config("ts_ls", {
				-- capabilities = capabilities,
			})
			vim.lsp.config("bashls", {
				-- capabilities = capabilities,
			})
			vim.lsp.config("cssls", {
				-- capabilities = capabilities,
			})
			vim.lsp.config("jdtls", {
				-- capabilities = capabilities,
			})
			vim.lsp.config("clangd", {
				-- capabilities = capabilities,
			})
			vim.lsp.config("gopls", {
				-- capabilities = capabilities,
			})
			vim.lsp.config("html", {
				-- capabilities = capabilities,
			})
			vim.lsp.config("cssls", {
				-- capabilities = capabilities,
			})
			vim.lsp.config("lua_ls", {
				-- capabilities = capabilities,
			})
			vim.lsp.config("hls", {
				-- capabilities = capabilities,
			})
			vim.diagnostic.config({
				virtual_text = {
					prefix = "●",
					spacing = 2,
				},
				float = {
					border = "rounded",
					focusable = false,
					prefix = "●",
				},
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = false,
			})

			vim.keymap.set("n", "<leader>h", function()
				vim.lsp.buf.hover({
					border = "rounded",
					stylize_markdown = true,
				})
			end)

			vim.keymap.set("n", "<leader>w", vim.diagnostic.open_float, {})
			vim.keymap.set("n", "<leader>g", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n", "v" }, "<leader>.", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<leader>,", function()
				vim.diagnostic.jump({ count = 1, float = true })
			end)
			vim.keymap.set("n", "<leader>o", organize_imports, {})
		end,
	},
}
