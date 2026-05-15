return {
	"supermaven-inc/supermaven-nvim",
	event = "InsertEnter",
	config = function()
		require("supermaven-nvim").setup({
			keymaps = {
				accept_suggestion = "<A-Tab>",
				clear_suggestion = "<A-c>",
				accept_word = "<A-j>",
			},
			disable_inline_completion = false,
			disable_keymaps = false,
		})
	end,
}
