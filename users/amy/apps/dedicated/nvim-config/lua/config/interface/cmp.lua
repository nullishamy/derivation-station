---@type ConfigModule
local module = {
  pkgs = {
    {
      'hrsh7th/nvim-cmp',
      config = function()
        local cmp = require('cmp')

        local icons = {
          Text = '',
          Method = '',
          Function = '',
          Constructor = '',
          Field = 'ﰠ',
          Variable = '',
          Class = '',
          Interface = '',
          Module = '',
          Property = '',
          Unit = '',
          Value = '',
          Enum = '',
          Keyword = '',
          Snippet = '',
          Color = '',
          File = '',
          Reference = '',
          Folder = '',
          EnumMember = '',
          Constant = '',
          Struct = 'פּ',
          Event = '',
          Operator = '',
          TypeParameter = '',
        }

        local luasnip = require('luasnip')

        local options = {
          snippet = {
            expand = function(args)
              require('luasnip').lsp_expand(args.body)
            end,
          },
          formatting = {
            format = function(_, vim_item)
              vim_item.kind = string.format('%s %s', icons[vim_item.kind], vim_item.kind)

              return vim_item
            end,
          },
          mapping = {
            ['<Tab>'] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              elseif luasnip.jumpable(1) then
                luasnip.jump(1)
              else
                fallback()
              end
            end, { 'i', 's' }),

            ['<S-Tab>'] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
              else
                fallback()
              end
            end, { 'i', 's' }),
            ['<ESC>'] = cmp.mapping.close(),
            ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
            ['<CR>'] = cmp.mapping.confirm {
              behavior = cmp.ConfirmBehavior.Insert,
              select = true,
            },
          },
          sources = {
            { name = 'luasnip' },
            { name = 'buffer' },
            { name = 'nvim_lua' },
            { name = 'path' },
            { name = 'emoji' },
            { name = 'spell' },
            { name = 'latex_symbols' },
          },
        }

        cmp.setup(options)
      end,
      dependencies = {
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'saadparwaiz1/cmp_luasnip' },
        { 'L3MON4D3/LuaSnip' },
      },
    },
  },
}

return module
