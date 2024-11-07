---@type ConfigModule
local module = {
  hooks = {
    init = function(state)
      if vim.g.neovide then
        vim.o.guifont = 'Iosevka Term:h14'
        vim.g.neovide_scroll_animation_length = 0.1
        vim.g.neovide_cursor_animation_length = 0
      end
    end,
  },
}

return module
