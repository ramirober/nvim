return {
	"goolord/alpha-nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.startify")
		-- local dashboard = require("alpha.themes.dashboard")

		dashboard.section.header.val = {
			-- [[▗▖  ▗▖▗▖  ▗▖▗▄▄▄▖▗▖  ▗▖]],
			-- [[▐▛▚▖▐▌▐▌  ▐▌  █  ▐▛▚▞▜▌]],
			-- [[▐▌ ▝▜▌▐▌  ▐▌  █  ▐▌  ▐▌]],
			-- [[▐▌  ▐▌ ▝▚▞▘ ▗▄█▄▖▐▌  ▐▌]],
		}

		alpha.setup(dashboard.opts)

		-- Abrir neo-tree después de que alpha termine
		vim.api.nvim_create_autocmd("User", {
			pattern = "LazyVimStarted", -- Evento que se dispara cuando lazy termina de cargar
			callback = function()
				if vim.fn.argc() == 0 then -- Solo si no se abrieron archivos
					vim.defer_fn(function()
						vim.cmd("Neotree action=show")
					end, 100)
				end
			end,
		})
	end,
}
