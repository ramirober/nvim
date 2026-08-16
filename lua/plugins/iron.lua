-- REPL interactivo: manda bloques de código del buffer a un IPython vivo.
-- El flujo es el de un notebook pero sobre un .py normal: separás el archivo en
-- celdas con `# %%` y mandás la celda bajo el cursor con <leader>c.
-- Los plots salen en ventanas nativas de macOS (backend `macosx`), no en la terminal.
return {
	"Vigemus/iron.nvim",
	ft = { "python" },
	config = function()
		local iron = require("iron.core")
		local view = require("iron.view")
		local common = require("iron.fts.common")

		-- Resolver el ipython del venv del proyecto en vez del global.
		-- Sin esto, abrir nvim fuera de un venv activado te daría un IPython
		-- sin numpy/matplotlib instalados.
		local function ipython_cmd()
			-- `--matplotlib=osx` engancha el event loop de Cocoa: plt.show() no
			-- bloquea y las ventanas quedan interactivas (zoom, pan, guardar).
			local args = { "--no-autoindent", "--matplotlib=osx" }

			local candidates = {}
			local venv = os.getenv("VIRTUAL_ENV")
			if venv then
				table.insert(candidates, venv .. "/bin/ipython")
			end
			-- .venv en la raíz del proyecto, buscando hacia arriba desde el archivo
			local found = vim.fs.find(".venv", {
				upward = true,
				type = "directory",
				path = vim.fn.expand("%:p:h"),
			})[1]
			if found then
				table.insert(candidates, found .. "/bin/ipython")
			end

			for _, bin in ipairs(candidates) do
				if vim.fn.executable(bin) == 1 then
					return vim.list_extend({ bin }, args)
				end
			end
			if vim.fn.executable("ipython") == 1 then
				return vim.list_extend({ "ipython" }, args)
			end
			-- Último recurso: que al menos abra algo en vez de fallar en silencio
			vim.notify("iron: no encontré ipython, uso python3", vim.log.levels.WARN)
			return { "python3" }
		end

		iron.setup({
			config = {
				scratch_repl = true,
				repl_definition = {
					python = {
						command = ipython_cmd,
						-- Manda el bloque con bracketed paste: IPython lo recibe como
						-- una unidad y no se le desarma la indentación.
						format = common.bracketed_paste_python,
						block_dividers = { "# %%", "#%%" },
					},
				},
				repl_filetype = function(_, ft)
					return ft .. "-repl"
				end,
				-- Split vertical a la derecha, 40% del ancho
				repl_open_cmd = view.split.vertical.botright(0.4),
			},
			keymaps = {
				toggle_repl = "<leader>i",
				restart_repl = "<leader>sR",
				send_motion = "<leader>sm",
				visual_send = "<leader>s",
				send_file = "<leader>sf",
				send_line = "<leader>sl",
				send_until_cursor = "<leader>su",
				send_code_block = "<leader>C",
				send_code_block_and_move = "<leader>c",
				exit = "<leader>sq",
				clear = "<leader>sx",
			},
			highlight = { italic = false },
			ignore_blank_lines = true,
		})

		-- Navegación entre celdas `# %%`, sólo en buffers Python para no pisar
		-- el ]c/[c nativo de diff en otros filetypes.
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "python",
			callback = function(args)
				local function jump(flags)
					vim.fn.search("^# *%%", flags)
				end
				vim.keymap.set("n", "]c", function()
					jump("W")
				end, { buffer = args.buf, desc = "Celda siguiente" })
				vim.keymap.set("n", "[c", function()
					jump("bW")
				end, { buffer = args.buf, desc = "Celda anterior" })
			end,
		})
	end,
}
