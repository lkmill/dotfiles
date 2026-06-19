return {
  {
    'neovim/nvim-lspconfig',
    config = function()
      local servers = { 'clangd', 'lua_ls', 'pyright', 'ts_ls' }

      for _, lsp in pairs(servers) do
        vim.lsp.enable(lsp)
      end

      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.HINT] = '',
            [vim.diagnostic.severity.INFO] = '',
          },
        },
      })
    end,
  },
}
