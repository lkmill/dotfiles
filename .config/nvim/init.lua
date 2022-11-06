local ok, reload = pcall(require, 'plenary.reload')

if ok then
  reload.reload_module('usr')
end

require('usr.options')
require('usr.maps')
require('usr.plugins')
require('usr.lsp')
require('usr.cmp')
require('usr.treesitter')
