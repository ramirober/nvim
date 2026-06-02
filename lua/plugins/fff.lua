return {
	"dmtrKovalenko/fff.nvim",
	build = function()
		require("fff.download").download_or_build_binary()
	end,
	lazy = false,
	opts = {
		debug = {
			enabled = false,
		},
	},
	keys = {
		{
			"<leader>p",
			function()
				require("fff").find_files()
			end,
		},
		{
			"<leader>l",
			function()
				require("fff").live_grep()
			end,
		},
	},
	-- Config funtion
	config = function()
		require("fff").setup({
			base_path = vim.fn.getcwd(),
			prompt = "> ",
			title = "Seach Files",
			max_results = 100,
			max_threads = 4,
			lazy_sync = true,
			prompt_vim_mode = false,
			layout = {
				height = 0.5,
				width = 0.8,
				prompt_position = "top", -- or 'top'
				preview_position = "right", -- 'left' | 'right' | 'top' | 'bottom'
				preview_size = 0.5,
				flex = { size = 130, wrap = "top" },
				min_list_height = 10, --  do not display anything except the list below this threshold
				show_scrollbar = true,
				path_shorten_strategy = "middle_number", -- 'middle_number' | 'middle' | 'end' | 'start'
				anchor = "center",
			},
			preview = {
				enabled = false,
				max_size = 10 * 1024 * 1024,
				chunk_size = 8192,
				binary_file_threshold = 1024,
				imagemagick_info_format_str = "%m: %wx%h, %[colorspace], %q-bit",
				line_numbers = false,
				cursorlineopt = "both",
				wrap_lines = false,
				filetypes = {
					svg = { wrap_lines = true },
					markdown = { wrap_lines = true },
					text = { wrap_lines = true },
				},
			},
			keymaps = {
				close = "<Esc>",
				select = "<CR>",
				select_split = "<C-s>",
				select_vsplit = "<C-v>",
				select_tab = "<C-t>",
				move_up = { "<Up>", "<C-p>" },
				move_down = { "<Down>", "<C-n>" },
				preview_scroll_up = "<C-u>",
				preview_scroll_down = "<C-d>",
				toggle_debug = "<F2>",
				cycle_grep_modes = "<S-Tab>",
				cycle_previous_query = "<C-Up>",
				toggle_select = "<Tab>",
				send_to_quickfix = "<C-q>",
				focus_list = "<leader>l",
				focus_preview = "<leader>p",
			},
			frecency = {
				enabled = true,
				db_path = vim.fn.stdpath("cache") .. "/fff_nvim",
			},
			history = {
				enabled = true,
				db_path = vim.fn.stdpath("data") .. "/fff_queries",
				min_combo_count = 3,
				combo_boost_score_multiplier = 100,
			},
			git = {
				status_text_color = false, -- true to color filenames by git status
			},
			grep = {
				max_file_size = 10 * 1024 * 1024,
				max_matches_per_file = 100,
				smart_case = true,
				time_budget_ms = 150,
				modes = { "plain", "regex", "fuzzy" },
				trim_whitespace = true,
				location_format = ":%d:%d", -- printf format for line:col prefix in grep results, e.g. ':%d' for line-only
			},
			debug = {
				enabled = false, -- show the file info panel next to the preview
				show_scores = false, -- inline scores in the file list
				-- Per-section toggles for the file info panel. Accepts a boolean shorthand
				-- (`show_file_info = true|false`) to flip everything at once. The panel
				-- adapts to width: narrow renders sections vertically, wide renders them
				-- as a two-column grid. Disable a section to also shrink the panel.
				show_file_info = {
					file_info = true, -- size, type, git status, frecency
					score_breakdown = true, -- total + match type, bonuses, modifiers, penalty
					-- modified + accessed timestamps; pass a table to hide individual rows:
					--   timings = { modified = false, accessed = true }
					timings = true,
					full_path = true, -- relative path at the bottom (wraps if too long)
				},
			},
			logging = {
				enabled = true,
				log_file = vim.fn.stdpath("log") .. "/fff.log",
				log_level = "info",
			},
		})
	end,
}
