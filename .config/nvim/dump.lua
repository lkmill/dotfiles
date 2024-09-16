packer.init({
  package_root = putil.join_paths(fn.stdpath('data'), 'site', 'pack')
})

  -- git
  use('tpope/vim-fugitive')
  use('lewis6991/gitsigns.nvim')
  use('akinsho/nvim-toggleterm.lua')

  -- colors
  use('tjdevries/colorbuddy.nvim')
  use('tjdevries/gruvbuddy.nvim')
  use('tanvirtin/monokai.nvim')



  -- checkout
  use('kevinhwang91/nvim-bqf')

cmd('colorscheme monokai')

--highlight MatchTag ctermfg=green ctermbg=black cterm=bold guifg=green guibg=black
-- set title

---- COLORS

require('colorbuddy').colorscheme('gruvbuddy')

local Color = require('colorbuddy').Color
local Group = require('colorbuddy').Group
local c = require('colorbuddy').colors
local s = require('colorbuddy').styles
local g = require('colorbuddy').groups

Color.new('red',       '#cc66ff')

Group.new("tsGenerics", c.blue:dark(), nil, s.bold)
Group.new("tsxTypes", c.blue:light(), nil, s.bold)
Group.new("typescriptBraces", c.blue:dark(), nil, nil)
Group.new("tsxElseOperator", c.yellow, nil, nil)

Group.new("typescriptType", g.Type, nil, g.Type.style + s.bold)
-- Group.new('typescriptStorageClass', c.teal:light())
Group.new("typescriptStorageClass", c.purple:light())

Group.new("tsxTagName", c.orange)
Group.new("tsxCloseTagName", g.tsxTagName)
Group.new("tsxTag", g.tsxTagName.fg:light(), nil, s.bold)



---- FZF
vim.env.FZF_DEFAULT_COMMAND = "rg --files --ignore-file .rgignore --hidden --follow --glob '!.git/*' --glob '!*.png' --glob '!*.jpg'"

-- mappings > FZF fuzzy finding
map('n', '<leader>f', ':Files<CR>')
map('n', '<leader>b', ':Buffers<CR>')
map('n', '<leader>B', ':Buffers<CR>')


---- mappings > fugitive
map('n', '<leader>gd', ':Gdiff<CR>')
map('n', '<leader>gs', ':Gstatus<CR>')
map('n', '<leader>gb', ':Gblame<CR>')
map('n', '<leader>gB', ':Gblame -w<CR>')

---- terminal

require('toggleterm').setup({
  -- size can be a number or function which is passed the current terminal
  size = function(term)
    if term.direction == 'horizontal' then
      return 15
    elseif term.direction == 'vertical' then
      return vim.o.columns * 0.4
    end
  end,
  open_mapping = [[<c-\>]],
  hide_numbers = true, -- hide the number column in toggleterm buffers
  shade_filetypes = {},
  shade_terminals = false,
  -- shading_factor = '<number>', -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
  start_in_insert = true,
  insert_mappings = true, -- whether or not the open mapping applies in insert mode
  persist_size = true,
  direction = 'horizontal', -- 'vertical' | 'horizontal' | 'window' | 'float',
  close_on_exit = true, -- close the terminal window when the process exits
  shell = vim.o.shell, -- change the default shell
  -- This field is only relevant if direction is set to 'float'
  -- float_opts = {
  --   -- The border key is *almost* the same as 'nvim_win_open'
  --   -- see :h nvim_win_open for details on borders however
  --   -- the 'curved' border is a custom border type
  --   -- not natively supported but implemented in this plugin.
  --   border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
  --   width = <value>,
  --   height = <value>,
  --   winblend = 3,
  --   highlights = {
  --     border = 'Normal',
  --     background = 'Normal',
  --   }
  -- }
})
