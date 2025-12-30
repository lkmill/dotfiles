return {
  'tpope/vim-commentary',
  'tpope/vim-fugitive',
  'tpope/vim-repeat',
  'tpope/vim-surround',
  'christoomey/vim-tmux-navigator',
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {'nvim-lua/plenary.nvim'},
  },
  {
    'kelly-lin/ranger.nvim',
    config = function()
      require('ranger-nvim').setup({
        replace_netrw = true,
        ui = {
          width = 0.8,
          height = 0.8,
        },
      })
      vim.api.nvim_set_keymap('n', '<leader>r', "", {
        noremap = true,
        callback = function()
          require('ranger-nvim').open(true)
        end,
      })
    end,
  },
}
