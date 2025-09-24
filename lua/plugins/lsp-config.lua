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
				ensure_installed = { "lua_ls", "ts_ls", "html", "cssls", "clangd" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			virtual_text = false
			local function organize_imports()
				local params = {
					command = "_typescript.organizeImports",
					arguments = { vim.api.nvim_buf_get_name(0) },
					title = "",
				}
				vim.lsp.buf.execute_command(params)
			end

			-- Using vim.lsp.config instead of require('lspconfig')
			vim.lsp.config("ts_ls", {
				capabilities = capabilities,
				commands = {
					OrganizeImports = {
						organize_imports,
						description = "Organize Imports",
					},
				},
			})

			vim.lsp.config("jdtls", {
				capabilities = capabilities,
			})

			vim.lsp.config("clangd", {
				capabilities = capabilities,
			})

			vim.lsp.config("gopls", {
				capabilities = capabilities,
			})

			vim.lsp.config("html", {
				capabilities = capabilities,
			})

			vim.lsp.config("cssls", {
				capabilities = capabilities,
			})

			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
			})

			vim.lsp.config("hls", {
				capabilities = capabilities,
			})

			vim.diagnostic.config({
				virtual_text = {
					prefix = "● ", -- Could be '●', '▎', 'x'
					spacing = 2,
				},
				float = {
					border = "rounded", -- styles: "single", "double", "rounded", "solid", "shadow"
					focusable = false,
					-- source = "always",
					prefix = "● ", -- Could be '●', '▎', 'x'",
				},
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = false,
			})

			-- vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>h", function()
				vim.lsp.buf.hover({
					border = "rounded",
				})
			end)
			vim.keymap.set("n", "<leader>w", vim.diagnostic.open_float, {})
			vim.keymap.set("n", "<leader>g", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n", "v" }, "<leader>.", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<leader>,", vim.diagnostic.goto_next, {})
			vim.keymap.set("n", "<leader>o", ":OrganizeImports<CR>", {})
		end,
	},
}
