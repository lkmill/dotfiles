-- TODO check if any should be nmap whateves
local map = require('util').map

---- MAPPINGS 
vim.g.mapleader = ' '
vim.g.tmux_navigator_no_mappings = 1

map('n', '<leader>n', ':setlocal relativenumber!<CR>')


-- navigate windows
map('n', '<M-h>', ':TmuxNavigateLeft<cr>')
map('n', '<M-j>', ':TmuxNavigateDown<cr>')
map('n', '<M-k>', ':TmuxNavigateUp<cr>')
map('n', '<M-l>', ':TmuxNavigateRight<cr>')
map('n', '<M-/>', ':TmuxNavigatePrevious<cr>')
map('n', '<leader><Space>', ':b#<CR>')

-- Resize with arrows
map('n', '<M-Up>', ':resize +2<CR>')
map('n', '<M-Down>', ':resize -2<CR>')
map('n', '<M-Left>', ':vertical resize -2<CR>')
map('n', '<M-Right>', ':vertical resize +2<CR>')

-- change current working directory
map('n', '<leader>cd', ':cd %:p:h<CR>:pwd<CR>')

-- clear search result highlights
map('n', '<leader>/', ':nohl<CR>')

-- Stay in indent mode
map('v', '<', '<gv')
map('v', '>', '>gv')

-- readline mappings in insert mode
map('i', '<C-a>', '<home>')
map('i', '<C-b>', '<left>')
map('i', '<C-f>', '<right>')
map('i', '<C-d>', '<del>')

-- readline mappings in command-line mode
map('c', '<C-a>', '<home>')
map('c', '<C-b>', '<left>')
map('c', '<C-f>', '<right>')
map('c', '<C-d>', '<del>')

-- print dates
map('n', '<leader>d', ':read !date<CR>A')
map('n', '<leader>D', ':read !date<CR>A: ')

-- mappings > buffers
map('n', '<leader>qw', ':bp<bar>sp<bar>bn<bar>bw<CR>')
map('n', '<leader>qW', ':bp<bar>sp<bar>bn<bar>bw!<CR>')
map('n', '<leader>qd', ':bp<bar>sp<bar>bn<bar>bd<CR>')
map('n', '<leader>qD', ':bp<bar>sp<bar>bn<bar>bd!<CR>')
map('n', '<leader>qa', ':bufdo bd<CR>')
map('n', '<leader>qA', ':bufdo bd!<CR>')
map('n', '<leader>w', ':w<CR>')
map('n', '<leader>W', ':wa<CR>')

-- mappings > Telescope
map('n', '<leader>f', ':Telescope find_files<CR>')
map('n', '<leader>b', ':Telescope buffers<CR>')
map('n', '<leader>F', ':Telescope ', false)

-- mappings > fugitive
map('n', '<leader>gd', ':Gdiff<CR>')
map('n', '<leader>gs', ':Gstatus<CR>')
map('n', '<leader>gb', ':Git blame<CR>')
map('n', '<leader>gB', ':Git blame -w<CR>')

-- mappings > editing and sourcing vim configs
map('n', '<leader>cg', ':e ~/.config/git/config<CR>')
map('n', '<leader>ci', ':e ~/.config/i3/config<CR>')
map('n', '<leader>cs', ':e ~/.ssh/config<CR>')
map('n', '<leader>ct', ':e ~/.config/tmux/tmux.conf<CR>')
map('n', '<leader>cT', ':e ~/.config/task/taskrc<CR>')
map('n', '<leader>cv', ':e ~/.config/nvim/init.lua<CR>')
map('n', '<leader>cw', ':e ~/.config/sway/config<CR>')
map('n', '<leader>cz', ':e ~/.zshrc<CR>')
map('n', '<leader>Cv', ':luafile ~/.config/nvim/init.lua<CR>', false)
map('n', '<leader>Cc', ':source ~/.vim/colors/sup3rman.vim<CR>')

-- mappings > use <C-n> and <C-p> to cycle through buffers
map('n', '<C-n>', ':bnext<CR>')
map('n', '<C-p>', ':bprev<CR>')

-- normal: move lines
map('n', '<C-j>', ':<C-u>exe "move +" . v:count1<CR>')
map('n', '<C-k>', ':<C-u>exe "move -" . (v:count1 + 1)<CR>')

-- visual: move lines
map('v', '<C-j>', ':<C-u>exe "\'<,\'>move \'>+" . v:count1<CR>gv')
map('v', '<C-k>', ':<C-u>exe "\'<,\'>move \'<-" . (v:count1 + 1)<CR>gv')

-- visual block: move lines
map('x', '<C-j>', ':<C-u>exe "\'<,\'>move \'>+" . v:count1<CR>gv')
map('x', '<C-k>', ':<C-u>exe "\'<,\'>move \'<-" . (v:count1 + 1)<CR>gv')

-- mappings > folds
map('n', 'zV', 'zMzv')
map('n', '<C-h>', 'zc')
map('n', '<M-C-h>', 'zC')
map('n', '<C-l>', 'zo')
map('n', '<M-C-l>', 'zO')

-- mappings > tabs
map('n', '<M-C-n>', ':tabnext<CR>')
map('n', '<M-C-p>', ':tabprev<CR>')

-- mappings > replace word under cursor
map('n', '<leader>s', ':%s/<C-R><C-W>/', false)

-- SWE > ENG ---

map('i', '<C-å>', '<esc>')

map('n', 'å', '[')
map('n', 'Å', '{')
map('n', 'ö', ';')
map('n', 'Ö', ':')
map('n', 'ä', "'")
map('n', 'Ä', '"')
