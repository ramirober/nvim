local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- local neocodeium = require("neocodeium")
-- local blink = require("blink.cmp")

if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

-- vim.api.nvim_create_autocmd("User", {
-- 	pattern = "BlinkCmpMenuOpen",
-- 	callback = function()
-- 		neocodeium.clear()
-- 	end,
-- })
-- 
-- neocodeium.setup({
-- 	filter = function()
-- 		return not blink.is_visible()
-- 	end,
-- })

-- Load personal settings on /lua/ramiro/init.lua
require("ramiro")
-- Load all plugins on /lua/plugins/*.lua
require("lazy").setup("plugins", {
	ui = {
		border = "rounded",
	},
})
