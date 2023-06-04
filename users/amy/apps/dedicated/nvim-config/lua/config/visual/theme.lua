---@type ConfigModule
local module = {
  pkgs = {
    {
      'catppuccin/nvim',
      name = 'catppuccin',
      config = function()
        vim.o.termguicolors = true
        vim.o.background = 'dark'

        local colors = require('catppuccin.palettes').get_palette('mocha')
        colors.none = 'NONE'

        require('catppuccin').setup {
          term_colours = true,
          flavour = 'mocha',
          no_italic = true,
          integrations = {
            treesitter = true,
            treesitter_context = true,
            --- FIXME: This is broken, awaiting update
            -- ts_rainbow = true,
            telescope = true,
            gitsigns = true,
            cmp = true,
            leap = true,
          },
          custom_highlights = {
            -- Fix float text background
            CmpPmenu = { fg = colors.none, bg = colors.none },
            NormalFloat = { fg = colors.none, bg = colors.none },

            -- Make builtins the same colour as regular values, for consistency
            ['@function.builtin'] = { fg = colors.blue },
            ['@const.builtin'] = { fg = colors.blue },
            ['@const'] = { fg = colors.blue },
            ['@keyword.export'] = { link = '@keyword' },
          },
        }

        vim.cmd([[ colorscheme catppuccin ]])
      end,
    },
  },
}

return module
