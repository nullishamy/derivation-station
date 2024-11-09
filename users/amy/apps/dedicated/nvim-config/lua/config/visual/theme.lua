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

        local active_background = colors.base
        local inactive_background = colors.base

        require('catppuccin').setup {
          term_colours = true,
          flavour = 'mocha',
          no_italic = true,
          integrations = {
            treesitter = true,
            treesitter_context = true,
            neotree = false,
            ts_rainbow = true,
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

            NeoTreeDirectoryName = { fg = colors.blue },
            NeoTreeDirectoryIcon = { fg = colors.blue },
            NeoTreeNormal = { fg = colors.text, bg = active_bg },
            NeoTreeNormalNcolors = { fg = colors.text, bg = active_bg },
            NeoTreeExpander = { fg = colors.overlay0 },
            NeoTreeIndentMarker = { fg = colors.overlay0 },
            NeoTreeRootName = { fg = colors.blue, style = { 'bold' } },
            NeoTreeSymbolicLinkTarget = { fg = colors.pink },
            NeoTreeModified = { fg = colors.peach },

            NeoTreeGitAdded = { fg = colors.green },
            NeoTreeGitcolorsonflict = { fg = colors.red },
            NeoTreeGitDeleted = { fg = colors.red },
            NeoTreeGitIgnored = { fg = colors.overlay0 },
            NeoTreeGitModified = { fg = colors.yellow },
            NeoTreeGitUnstaged = { fg = colors.red },
            NeoTreeGitUntracked = { fg = colors.mauve },
            NeoTreeGitStaged = { fg = colors.green },

            NeoTreeFloatBorder = { link = 'FloatBorder' },
            NeoTreeFloatTitle = { link = 'FloatTitle' },
            NeoTreeTitleBar = { fg = colors.mantle, bg = colors.blue },

            NeoTreeFileNameOpened = { fg = colors.pink },
            NeoTreeDimText = { fg = colors.overlay1 },
            NeoTreeFilterTerm = { fg = colors.green, style = { 'bold' } },
            NeoTreeTabActive = { bg = active_bg, fg = colors.lavender, style = { 'bold' } },
            NeoTreeTabInactive = { bg = inactive_bg, fg = colors.overlay0 },
            NeoTreeTabSeparatorActive = { fg = active_bg, bg = active_bg },
            NeoTreeTabSeparatorInactive = { fg = inactive_bg, bg = inactive_bg },
            NeoTreeVertSplit = { fg = colors.base, bg = inactive_bg },
            NeoTreeWinSeparator = {
              fg = colors.base,
              bg = colors.base,
            },
            NeoTreeStatusLineNC = { fg = colors.mantle, bg = colors.mantle },
          },
        }

        vim.cmd([[ colorscheme catppuccin ]])
      end,
    },
  },
}

return module
