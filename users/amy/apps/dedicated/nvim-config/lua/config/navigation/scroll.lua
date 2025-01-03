---@type ConfigModule
local module = {
  enable = false,
  pkgs = {
    {
      'karb94/neoscroll.nvim',
      config = function()
        require('neoscroll').setup {}

        local t = {}
        -- Syntax: t[keys] = {function, {function arguments}}
        t['<C-u>'] = { 'scroll', { '-vim.wo.scroll', 'true', '150' } }
        t['<C-d>'] = { 'scroll', { 'vim.wo.scroll', 'true', '150' } }
        t['K'] = { 'scroll', { '-10', 'true', '50' } }
        t['J'] = { 'scroll', { '10', 'true', '50' } }

        require('neoscroll.config').set_mappings(t)
      end,
    },
  },
}

return module
