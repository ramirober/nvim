-- Leader mapping (space)
vim.g.mapleader = " "

-- Set the number of spaces a <Tab> counts for while performing editing operations
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
-- Set the number of spaces to use for each step of (auto)indent
vim.opt.shiftwidth = 2
-- Use the appropriate number of spaces to insert a <Tab>
vim.opt.expandtab = true

-- Smart indent: do smart autoindenting when starting a new line
vim.opt.smartindent = true

vim.opt.wrap = false

-- Enable line numbers
vim.opt.nu = true
-- Enable relative line numbers
vim.opt.relativenumber = true

vim.opt.termguicolors = true

vim.o.signcolumn = "yes"

-- Hide ~ characters on empty lines after end of buffer
vim.opt.fillchars = { eob = " " }

-- Auto-recargar archivos modificados fuera de Neovim (agentes IA, git, etc.)
-- autoread ya viene activo por defecto; el checktime es el que dispara la detección.
-- FocusGained es el trigger clave (volver a Neovim tras el agente): instantáneo y sin costo.
vim.opt.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI", "TermClose", "TermLeave" }, {
	pattern = "*",
	callback = function()
		-- No recargar mientras estamos en una terminal (ej. lazygit flotante):
		-- lazygit cambia archivos en disco constantemente y el checktime al volver
		-- el foco recargaría todos los buffers, corrompiendo la flotante.
		if vim.bo.buftype == "terminal" then
			return
		end
		if vim.fn.mode() ~= "c" and vim.fn.getcmdwintype() == "" then
			vim.cmd("checktime")
		end
	end,
})

-- Al volver el foco a un buffer de terminal (cambiar de pestaña en Ghostty y
-- volver), Neovim sale del modo terminal-insert. Re-entramos automáticamente
-- para no perder el foco de input de lazygit y otras terminales.
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained" }, {
	pattern = "*",
	callback = function()
		if vim.bo.buftype == "terminal" then
			vim.cmd("startinsert")
		end
	end,
})

-- Aviso discreto cuando un archivo se recargó solo
vim.api.nvim_create_autocmd("FileChangedShellPost", {
	pattern = "*",
	callback = function()
		vim.notify("Archivo recargado (cambió en disco)", vim.log.levels.INFO)
	end,
})

-- Keybind for switching between last two opened files
vim.keymap.set("n", "<leader><leader>", "<C-^>")

-- LSP rename (reemplaza renamer.nvim)
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { desc = "LSP rename" })

-- Commenting (built-in en Neovim 0.10+, reemplaza Comment.nvim)
vim.keymap.set("n", "<leader>n", "gcc", { remap = true, desc = "Toggle comment line" })
vim.keymap.set("x", "<leader>n", "gc", { remap = true, desc = "Toggle comment selection" })
vim.keymap.set("n", "<leader>m", "gcc", { remap = true, desc = "Toggle comment line" })
vim.keymap.set("x", "<leader>m", "gc", { remap = true, desc = "Toggle comment selection" })

-- Use system clipboard
vim.api.nvim_set_option("clipboard", "unnamed")

-- ¿Hay una ventana de neo-tree visible en la pestaña actual?
local function neotree_is_open()
	for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
		if vim.bo[vim.api.nvim_win_get_buf(win)].filetype == "neo-tree" then
			return true
		end
	end
	return false
end

-- Smart buffer close: cierra buffer, no Neovim. :qa para salir de Neovim.
local function smart_bufclose(opts)
	opts = opts or {}
	local current = vim.api.nvim_get_current_buf()
	local current_ft = vim.bo[current].filetype

	-- Si estamos en Alpha, cerrar Neovim
	if current_ft == "alpha" then
		vim.cmd("qa" .. (opts.force and "!" or ""))
		return
	end

	-- Guardar si se pidió
	if opts.write then
		vim.cmd("w" .. (opts.force and "!" or ""))
	end

	-- Filtrar buffers reales (excluir el actual y neo-tree)
	local bufs = vim.fn.getbufinfo({ buflisted = 1 })
	local real_bufs = vim.tbl_filter(function(b)
		return b.bufnr ~= current and vim.bo[b.bufnr].filetype ~= "neo-tree"
	end, bufs)

	if #real_bufs > 0 then
		table.sort(real_bufs, function(a, b)
			return (a.lastused or 0) > (b.lastused or 0)
		end)
		vim.api.nvim_set_current_buf(real_bufs[1].bufnr)
	elseif neotree_is_open() then
		-- Último buffer con el file explorer abierto: dejar Alpha para no
		-- cerrar neo-tree al irse la última ventana de edición (simil IDE)
		if pcall(require, "alpha") then
			vim.cmd("Alpha")
		else
			vim.cmd("enew")
		end
	else
		-- Último buffer sin file explorer: no hay nada que preservar, salir
		vim.cmd("qa" .. (opts.force and "!" or ""))
		return
	end
	vim.cmd("bdelete" .. (opts.force and "!" or "") .. " " .. current)
end

vim.api.nvim_create_user_command("Bd", function(c)
	smart_bufclose({ force = c.bang })
end, { bang = true })
vim.api.nvim_create_user_command("Q", function(c)
	smart_bufclose({ force = c.bang })
end, { bang = true })
vim.api.nvim_create_user_command("Wq", function(c)
	smart_bufclose({ write = true, force = c.bang })
end, { bang = true })

vim.keymap.set("n", "<leader>x", smart_bufclose, { desc = "Smart close buffer" })

-- Redirigir comandos nativos a los custom
vim.cmd("cabbrev bd Bd")
vim.cmd("cabbrev q Q")
vim.cmd("cabbrev wq Wq")
