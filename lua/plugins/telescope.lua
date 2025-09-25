return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>p", builtin.find_files, {})
			vim.keymap.set("n", "<leader>v", builtin.oldfiles, {})
			vim.keymap.set("n", "<leader>l", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>b", builtin.buffers, {})
			vim.keymap.set("n", "<leader>s", builtin.current_buffer_fuzzy_find, {})
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			-- TODO: Check sorting order (inverted) on dropdown theme and fix it
			-- local selectedTheme = "dropdown" -- Themes: dropdown, cursor, ivy
			require("telescope").setup({
				defaults = {
					-- theme = "dropdown",
					-- sorting_strategy = "ascending",
					-- selection_strategy = "follow",
					-- layout_strategy = "vertical",
					-- path_display = { "smart" },
					mappings = {
						n = {
							["dd"] = require("telescope.actions").delete_buffer,
						},
					},
				},
				pickers = {
					find_files = {
						-- theme = "dropdown",
						hidden = false,
						previewer = false,
            -- sorting_strategy = "ascending",
            -- layout_strategy = "vertical",
					},
					oldfiles = {
						-- theme = "dropdown",
						hidden = false,
						previewer = false,
						-- sorting_strategy = "ascending",
						initial_mode = "normal",
						only_cwd = true,
					},
					buffers = {
						theme = "dropdown",
						previewer = false,
						sort_lastused = true,
						sort_mru = true,
						initial_mode = "normal",
						ignore_current_buffer = true,
					},
					live_grep = {
						previewer = true,
					},
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({
							-- Dropdown theme options
						}),
					},
					extensions = {
						fzf = {
							fuzzy = true, -- false will only do exact matching
							override_generic_sorter = true, -- override the generic sorter
							override_file_sorter = true, -- override the file sorter
							case_mode = "smart_case", -- or "ignore_case" or "respect_case"
							-- the default case_mode is "smart_case"
						},
					},
				},
			})
			require("telescope").load_extension("ui-select")
			require("telescope").load_extension("fzf")
		end,
	},
}
