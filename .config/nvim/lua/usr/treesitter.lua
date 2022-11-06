local status_ok, configs = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
	return
end

local util = require('usr.util')

-- map('n', '<leader>u', '<cmd>lua print(vim.treesitter.statusline())<CR>')
util.map('n', '<leader>u', '<cmd>echo nvim_treesitter#statusline()<CR>')

configs.setup {
  ensure_installed = {
    'css',
    'html',
    'javascript',
    'jsdoc',
    'json',
    'lua',
    'python',
    'scss',
    'tsx',
    'typescript',
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = false,
  }
}
