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
      -- local selectedTheme = "dropdown"
      require("telescope").setup({
        pickers = {
          find_files = {
            -- theme = selectedTheme,
            hidden = false,
          },
          oldfiles = {
            -- theme = selectedTheme,
            hidden = false,
            initial_mode = "normal",
            only_cwd = true,
          },
          buffers = {
            -- theme = selectedTheme,
            sort_lastused = true,
            sort_mru = true,
            initial_mode = "normal",
          },
          live_grep = {
            -- theme = selectedTheme,
          },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
          extensions = {
            fzf = {
              fuzzy = true,                   -- false will only do exact matching
              override_generic_sorter = true, -- override the generic sorter
              override_file_sorter = true,    -- override the file sorter
              case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
              -- the default case_mode is "smart_case"
            },
          },
        },
        defaults = {
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
      })
      require("telescope").load_extension("ui-select")
      require("telescope").load_extension("fzf")
    end,
  },
}
