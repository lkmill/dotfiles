return {
  'tpope/vim-commentary',
  'tpope/vim-fugitive',
  'tpope/vim-repeat',
  'tpope/vim-surround',
  'christoomey/vim-tmux-navigator',
  {
    'loctvl842/monokai-pro.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('monokai-pro').setup()
      vim.cmd.colorscheme('monokai-pro')
    end,
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
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
      vim.api.nvim_set_keymap('n', '<leader>r', '', {
        noremap = true,
        callback = function()
          require('ranger-nvim').open(true)
        end,
      })
    end,
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        c = { 'clang_format' },
        cpp = { 'clang_format' },
        lua = { 'stylua' },
        javascript = { 'oxfmt' },
        javascriptreact = {
          'oxfmt',
        },
        typescript = { 'oxfmt' },
        typescriptreact = {
          'oxfmt',
        },
        python = { 'ruff_format' },
      },
      format_on_save = {
        -- I recommend these options. See :help conform.format for details.
        lsp_format = 'fallback',
        timeout_ms = 500,
      },
    },
  },
}
