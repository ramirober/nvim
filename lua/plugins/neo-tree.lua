return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    vim.keymap.set("n", "<leader>e", ":Neotree source=filesystem toggle reveal position=left<CR>")
    require("neo-tree").setup({
      filesystem = {
        filtered_items = {
          visible = true,
        },
      },
      close_if_last_window = true,
      source_selector = {
        winbar = true,
      },
      window = {
        width = 38,
      },
      enable_diagnostics = true,
      enable_git_status = true,
    })
  end,
}
