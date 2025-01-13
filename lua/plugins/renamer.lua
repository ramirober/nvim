return {
  "filipdutescu/renamer.nvim",
  branch = "master",                             -- specifying the branch
  dependencies = { { "nvim-lua/plenary.nvim" } }, -- dependency for Renamer
  config = function()
    -- Configuring the renamer
    require("renamer").setup({})

    -- Keybinding for renaming symbols
    -- vim.api.nvim_set_keymap(
    --   "i",
    --   "<F2>",
    --   '<cmd>lua require("renamer").rename()<CR>',
    --   { noremap = true, silent = true }
    -- )
    vim.api.nvim_set_keymap(
      "n",
      "<leader>r",
      '<cmd>lua require("renamer").rename()<CR>',
      { noremap = true, silent = true }
    )
  end,
}

