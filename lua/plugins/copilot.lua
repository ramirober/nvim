return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	config = function()
		require("copilot").setup({
			suggestion = {
				enabled = true,
				auto_trigger = true,
				keymap = {
					accept = false, -- Deshabilitamos el mapeo por defecto
					next = "<M-]>",
					prev = "<M-[>",
					dismiss = "<C-]>",
				},
			},
			panel = { enabled = false },
			copilot_node_command = "node", -- Node.js versión para usar
			server_opts_overrides = {
				trace = "verbose",
				settings = {
					advanced = {
						listCount = 10, -- #completions for panel
						inlineSuggestCount = 3, -- #completions for getCompletions
					}
				}
			}
		})

		-- Configurar keymaps condicionales
		vim.keymap.set("i", "<Tab>", function()
			local cmp = require("blink.cmp")
			if cmp.is_visible() then
				-- Si blink está abierto, usa Alt+Tab para copilot
				return "<M-Tab>"
			else
				-- Si blink está cerrado, acepta la sugerencia de copilot
				if require("copilot.suggestion").is_visible() then
					require("copilot.suggestion").accept()
				else
					return "<Tab>"
				end
			end
		end, { expr = true, silent = true })

		vim.keymap.set("i", "<M-Tab>", function()
			if require("copilot.suggestion").is_visible() then
				require("copilot.suggestion").accept()
			end
		end, { silent = true })
	end,
}
