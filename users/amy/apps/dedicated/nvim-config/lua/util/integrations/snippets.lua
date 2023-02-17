return {
  'L3MON4D3/LuaSnip',
  config = function()
    -- Load snipmate snippets
    require('luasnip.loaders.from_snipmate').lazy_load()
  end,
  dependencies = {
    {
      'honza/vim-snippets',
    },
  },
}
