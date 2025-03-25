return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "ts_ls", "html", "cssls", "clangd" },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local lspconfig = require("lspconfig")

      local function organize_imports()
        local params = {
          command = "_typescript.organizeImports",
          arguments = { vim.api.nvim_buf_get_name(0) },
          title = "",
        }
        vim.lsp.buf.execute_command(params)
      end

      lspconfig.ts_ls.setup({
        capabilities = capabilities,
        commands = {
          OrganizeImports = {
            organize_imports,
            description = "Organize Imports",
          },
        },
      })
      lspconfig.html.setup({
        capabilities = capabilities,
      })
      lspconfig.cssls.setup({
        capabilities = capabilities,
      })
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })
      lspconfig.clangd.setup({
        capabilities = capabilities,
      })
      lspconfig.hls.setup({
        capabilities = capabilities,
      })

      vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>g", vim.lsp.buf.definition, {})
      vim.keymap.set({ "n", "v" }, "<leader>.", vim.lsp.buf.code_action, {})
      vim.keymap.set("n", "<leader>,", vim.diagnostic.goto_next, {})
      vim.keymap.set("n", "<leader>o", ":OrganizeImports<CR>", {})
    end,
  },
}
