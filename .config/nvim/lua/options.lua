local opt = vim.opt

opt.syntax = 'off'
opt.termguicolors = true

opt.ruler = false
opt.number = true
opt.relativenumber = true
opt.wrap = false

-- BUFFERS

--set wildmenu
--set wildmode=list:longest,list:full
--set wildignore=.git,node_modules,bower_components
opt.hidden = true

---- SEARCH OPTIONS
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true

---- INDENTATION
opt.autoindent = false
opt.smartindent = false

opt.showtabline = 2                         -- always show tabs
opt.expandtab = true                        -- convert tabs to spaces
opt.shiftwidth = 2
opt.softtabstop = 2
opt.tabstop = 2

opt.splitbelow = true                       -- force all horizontal splits to go below current window
opt.splitright = true                       -- force all vertical splits to go to the right of current window
opt.updatetime = 300                        -- faster completion (4000ms default)
