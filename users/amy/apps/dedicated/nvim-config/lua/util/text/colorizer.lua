return {
  'uga-rosa/ccc.nvim',
  config = function()
    require('ccc').setup({
      exclude_pattern = {
        css_name = '*',
      },
      highlighter = {
        excludes = {
          'packer',
          'fterm_lazygit',
        },
        auto_enable = true,
      },
    })
  end,
}
