local M = {}

M.map = function(mode, key, result, silent)
  silent = (silent == nil and true) or silent

  vim.api.nvim_set_keymap(mode, key, result, { noremap = true, silent = silent })
end

return M
