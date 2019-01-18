if &compatible
  set nocompatible " be vimproved
endif

call plug#begin('~/.local/share/nvim/plugged')

" Colors
Plug 'morhetz/gruvbox'

" autocomplete
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}

" SYNTAX
Plug 'w0rp/ale'

" syntax > JS
Plug 'mxw/vim-jsx'
Plug 'othree/es.next.syntax.vim'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'othree/yajs.vim'
Plug 'Valloric/MatchTagAlways' "highlights nearest enclosing tags
Plug 'prettier/vim-prettier', {
   \ 'do': 'npm install',
   \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue'] }

" APPEARANCE
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" UTILITIES
Plug 'alvan/vim-closetag' "automagically close html tags
Plug 'christoomey/vim-tmux-navigator'
Plug 'honza/vim-snippets'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'rbgrouleff/bclose.vim' "required for ranger in vim
Plug 'wavded/vim-stylus'

" Plug 'francoiscabrol/ranger.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat' "needed to be able to use . for vim-surround commands
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'Valloric/ListToggle'

call plug#end()

filetype plugin indent on

syntax on

set bg=dark
colorscheme gruvbox

highlight MatchTag ctermfg=green ctermbg=black cterm=bold guifg=green guibg=black

set exrc

set number
set relativenumber
set ruler
set nowrap

set title

":: BUFFERS

set wildmenu
set wildmode=list:longest,list:full
set wildignore=.git,node_modules,bower_components
set hidden

":: SEARCH OPTIONS

set hlsearch
set incsearch
set ignorecase

":: INDENTATION

set autoindent
set smartindent

set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2

":: FOLDS
set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo

":: COMPLETION

set completeopt-=preview

":: PLUGINS

"plugins > bclose
let g:no_plugin_maps = 1

" plugins > closetag
let g:closetag_filenames = "*.html,*.marko,*.dust,*.jsx,*.ejs"

" plugins > MatchTagAlways
let g:mta_use_matchparen_group = 0
let g:mta_set_default_matchtag_color = 0
let g:mta_filetypes = { 'javascript.jsx': 1, 'html' : 1, 'marko' : 1, 'xhtml' : 1, 'xml' : 1, 'jinja' : 1, }
nnoremap <leader>5 :MtaJumpToOtherTag<cr>

" plugins > tmux navigator
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <M-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <M-j> :TmuxNavigateDown<cr>
nnoremap <silent> <M-k> :TmuxNavigateUp<cr>
nnoremap <silent> <M-l> :TmuxNavigateRight<cr>
nnoremap <silent> <M-/> :TmuxNavigatePrevious<cr>

" == ale ==
let g:ale_linters = { 'javascript': ['eslint'] }
let g:ale_fixers = {'javascript': ['prettier']}
" let g:ale_fix_on_save = 1

":: MAPPINGS 

let mapleader = "\<Space>"

" readline mappings in insert mode
imap <C-b> <left>
imap <C-f> <right>
imap <C-d> <del>

" remap q to Ctrl-q (should probably switch) since it is rarely used,
" and q can then be used for better bindings
nnoremap <C-q> q
nnoremap q <Nop>

"yank to end of current line
nnoremap Y y$

" fuk u

nnoremap <leader>d :read !date<CR>A
nnoremap <leader>D :read !date<CR>A: 


nnoremap qw :bp<bar>sp<bar>bn<bar>bw<CR>
nnoremap qW :bp<bar>sp<bar>bn<bar>bw!<CR>
nnoremap qd :bp<bar>sp<bar>bn<bar>bd<CR>
nnoremap qD :bp<bar>sp<bar>bn<bar>bd!<CR>
nnoremap qa :bufdo bd<CR>
nnoremap qA :bufdo bd!<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>W :wa<CR>

nnoremap <leader>n :setlocal relativenumber!<CR>

" FZF fuzzy finding
nnoremap <leader>f :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>B :Buffers<CR>
nnoremap <leader><Space> :b#<CR>

nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
nnoremap <leader>/ :nohl<CR>

" mappings > fugitive
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gB :Gblame w<CR>

" mappings > tagbar
nnoremap <leader>t :TagbarToggle<CR>

" mappings > editing and sourcing vim configs
nnoremap <leader>vr :e ~/.config/nvim/init.vim<CR>
nnoremap <leader>vc :e ~/.vim/colors/sup3rman.vim<CR>
nnoremap <leader>vsr :source ~/.config/nvim/init.vim<CR>
nnoremap <leader>vsc :source ~/.vim/colors/sup3rman.vim<CR>

" mappings > ranger
let g:ranger_map_keys = 0

" nmap <leader>r :call Ranger(1)<cr>
" nmap <leader>R :call Ranger(0)<cr>
nmap <leader>r :RangerWorkingDirectory<CR>
nmap <leader>R :Ranger<CR>

" mappings > use <C-n> and <C-p> to cycle through buffers
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprev<CR>

" mappings > move lines
nnoremap <C-j> :<C-u>exe "move +" . v:count1<CR>
nnoremap <C-k> :<C-u>exe "move -" . (v:count1 + 1)<CR>
vnoremap <C-j> :<C-u>exe "'<,'>move '>+" . v:count1<CR>gv
vnoremap <C-k> :<C-u>exe "'<,'>move '<-" . (v:count1 + 1)<CR>gv

" mappings > folds
nnoremap zV zMzv
nnoremap <C-h> zc
nnoremap <M-C-h> zC
nnoremap <C-l> zo
nnoremap <M-C-l> zO


nnoremap <M-C-n> :tabnext<CR>
nnoremap <M-C-p> :tabprev<CR>

nnoremap <silent> <leader>s :set spell!<CR>

":: COMMANDS

command! Nt NERDTree
command! Sv setl spelllang=sv
command! En setl spelllang=en_gb
command! Html set filetype=html
command! Php set filetype=php
command! Js set filetype=javascript
command! Css set filetype=css
command! Markdown set filetype=markdown

au BufRead,BufNewFile *.mjs setl filetype=javascript
au BufRead,BufNewFile .vimperatorrc setl filetype=vim
au BufRead,BufNewFile .eslintrc setl filetype=json
au BufRead,BufNewFile .babelrc setl filetype=json
au BufRead,BufNewFile *.md setl filetype=markdown
au BufRead,BufNewFile *.css setl filetype=scss
au BufRead,BufNewFile *.dust setl filetype=dustjs
au BufRead,BufNewFile *.ejs setl filetype=html
au BufRead,BufNewFile *.marko setl filetype=html
au BufRead,BufNewFile *.dust.html setl filetype=dustjs
au BufNewFile,BufRead *.tag setlocal ft=javascript

":: FILE TYPES
autocmd FileType less,scss,css setl synmaxcol=120 omnifunc=csscomplete#CompleteCSS foldmethod=marker foldmarker={,}
autocmd FileType php setl omnifunc=phpcomplete#CompletePHP foldmethod=indent
autocmd FileType marko,dustjs,html setl omnifunc=htmlcomplete#CompleteTags foldmethod=indent
autocmd FileType marko,dustjs,html let b:surround_99 = "<!--\r-->"
autocmd FileType javascript setl omnifunc=javascriptcomplete#CompleteJS foldmethod=indent
autocmd FileType json setl foldmethod=indent
autocmd FileType json setl expandtab
autocmd FileType text setl nosmartindent

":: FILE TYPES >> configs

autocmd FileType xf86conf setl tabstop=8 shiftwidth=8 softtabstop=8 expandtab
autocmd FileType nginx setl tabstop=4 shiftwidth=4 softtabstop=4 expandtab

":: FZF
" 
" from https://medium.com/@crashybang/supercharge-vim-with-fzf-and-ripgrep-d4661fc853d2
"
" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
"
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

" --files: List files that would be searched but do not search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)

let $FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git/*' --glob '!*.png' --glob '!*.jpg'"

":: Ranger
function! OpenRangerIn(path, edit_cmd)
  let currentPath = expand(a:path)
  let rangerCallback = { 'name': 'ranger', 'edit_cmd': a:edit_cmd }
  function! rangerCallback.on_exit(id, code, _event)
    silent! Bclose!
    try
      if filereadable('/tmp/chosenfile')
        exec system('sed -ie "s/ /\\\ /g" /tmp/chosenfile')
        exec 'argadd ' . system('cat /tmp/chosenfile | tr "\\n" " "')
        exec self.edit_cmd . system('head -n1 /tmp/chosenfile')
        call system('rm /tmp/chosenfile')
      endif
    endtry
  endfunction
  enew
  call termopen('ranger --choosefiles=/tmp/chosenfile --selectfile="' . currentPath . '"', rangerCallback)
  startinsert
endfunction

" For backwards-compatibility (deprecated)
if exists('g:ranger_open_new_tab') && g:ranger_open_new_tab
  let s:default_edit_cmd='tabedit '
else
  let s:default_edit_cmd='edit '
endif

command! RangerCurrentDirectory call OpenRangerIn("%:p", s:default_edit_cmd)
command! RangerWorkingDirectory call OpenRangerIn("", s:default_edit_cmd)
command! Ranger RangerCurrentDirectory
