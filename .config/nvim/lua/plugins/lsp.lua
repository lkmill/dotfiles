return {
  {
    'neovim/nvim-lspconfig',
    config = function ()
      local lspconfig = require('lspconfig')
      local servers = { 'pyright', 'ts_ls' }
      local signs = {
        { name = 'DiagnosticSignError', text = '' },
        { name = 'DiagnosticSignWarn', text = '' },
        { name = 'DiagnosticSignHint', text = '' },
        { name = 'DiagnosticSignInfo', text = '' },
      }

      for _, lsp in pairs(servers) do
        lspconfig[lsp].setup {
          flags = {
            -- This will be the default in neovim 0.7+
            debounce_text_changes = 150,
          }
        }
      end

      for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
      end
    end
  }
}

