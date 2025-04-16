return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
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
			local handlers = {
				["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
				["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
			}

			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local lspconfig = require("lspconfig")

			local function organize_imports()
				local params = {
					command = "_typescript.organizeImports",
					arguments = { vim.api.nvim_buf_get_name(0) },
					title = "",
				}
				vim.lsp.buf.execute_command(params)
			end

			lspconfig.ts_ls.setup({
				capabilities = capabilities,
				commands = {
					OrganizeImports = {
						organize_imports,
						description = "Organize Imports",
					},
				},
			})
			lspconfig.html.setup({
				capabilities = capabilities,
			})
			lspconfig.cssls.setup({
				capabilities = capabilities,
			})
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.clangd.setup({
				capabilities = capabilities,
			})
			lspconfig.hls.setup({
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
