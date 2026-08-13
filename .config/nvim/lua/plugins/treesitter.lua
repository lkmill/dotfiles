return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    local parsers = {
      'css',
      'html',
      'javascript',
      'jsdoc',
      'json',
      'lua',
      'markdown',
      'markdown_inline',
      'python',
      'query',
      'tsx',
      'typescript',
      'vim',
      'vimdoc',
    }

    require('nvim-treesitter').install(parsers)

    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        local lang = vim.treesitter.language.get_lang(args.match) or args.match

        local has_query = vim.treesitter.query.get(lang, 'highlights')

        if has_query then
          vim.treesitter.start(args.buf, lang)
        end
      end,
    })
  end,
}
