return {
  'nvim-telescope/telescope.nvim',
  config = function()
    require('telescope').setup({
      defaults = {
        mappings = {
          i = {
            ['<C-u>'] = false,
            ['<C-d>'] = false,
          },
        },
      },
      extensions = {
        ignore_patterns = {
          "*.git/*",
          "*/tmp/*",
          "*/node_modules/"
        }
      }
    })

    vim.g.sqlite_clib_path = vim.env.SQLITE_LIB_PATH
    require('telescope').load_extension('smart_open')
  end,
  dependencies = {
    {
      'kkharji/sqlite.lua',
    },
    {
      'danielfalk/smart-open.nvim'
    }
  },
}
