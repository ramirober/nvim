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
					"basedpyright",
					"ruff",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			-- local capabilities = require("cmp_nvim_lsp").default_capabilities()

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
				-- Lombok: jdtls necesita lombok.jar como javaagent para entender
				-- @Data y los getters/setters generados (mason ya lo trae con jdtls).
				cmd = {
					"jdtls",
					"--jvm-arg=-javaagent:" .. vim.fn.expand("$HOME/.local/share/nvim/mason/packages/jdtls/lombok.jar"),
				},
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
			-- Python: basedpyright hace tipos/hover/goto, ruff hace lint + fixes.
			vim.lsp.config("basedpyright", {
				settings = {
					basedpyright = {
						analysis = {
							-- El default de basedpyright ("recommended") es durísimo y llena
							-- de diagnósticos cualquier código con numpy/pandas/sklearn.
							typeCheckingMode = "standard",
							diagnosticMode = "openFilesOnly",
							autoImportCompletions = true,
						},
					},
				},
			})
			vim.lsp.config("ruff", {
				-- El hover de ruff es pobre y pisa al de basedpyright si ambos responden.
				on_attach = function(client)
					client.server_capabilities.hoverProvider = false
				end,
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
					max_width = 80,
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
