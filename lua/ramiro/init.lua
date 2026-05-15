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
	else
		-- Último buffer: abrir Alpha
		if pcall(require, "alpha") then
			vim.cmd("Alpha")
		else
			vim.cmd("enew")
		end
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
