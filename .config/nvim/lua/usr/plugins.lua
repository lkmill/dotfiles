local cmd = vim.cmd
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

local bootstrapped

if fn.empty(fn.glob(install_path)) > 0 then
  bootstrapped = cmd('!git clone --depth 1 https://github.com/wbthomason/packer.nvim ' .. install_path)

  if vim.v.shell_error ~= 0 then
	  return
  end

  cmd('packadd packer.nvim')
end

local packer = require('packer')

packer.startup(function ()
  use('wbthomason/packer.nvim')

  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use('kevinhwang91/rnvimr')

  use('neovim/nvim-lspconfig')
  use('hrsh7th/cmp-nvim-lsp')
  use('hrsh7th/cmp-buffer')
  use('hrsh7th/cmp-path')
  use('hrsh7th/cmp-cmdline')
  use('hrsh7th/nvim-cmp')
  use 'hrsh7th/cmp-nvim-lua'
  
  use('L3MON4D3/LuaSnip')
  use('saadparwaiz1/cmp_luasnip')
  use('rafamadriz/friendly-snippets')

  -- tree-sitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use('nvim-treesitter/playground')

  -- util
  use('tpope/vim-commentary')
  use('tpope/vim-fugitive')
  use('tpope/vim-repeat')
  use('tpope/vim-surround')
  use('christoomey/vim-tmux-navigator')
  use('jiangmiao/auto-pairs')

  use('/home/lohfu/dev/nvim-join')

  if bootstrapped then
	packer.sync()
	end
end)

