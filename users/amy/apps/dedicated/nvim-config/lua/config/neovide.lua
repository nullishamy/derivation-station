local fonts = {
  ['iosevka_term'] = 'Iosevka Term Light',
  ['recursive'] = 'Recursive Mono Linear Static:h14',
  ['fantasque'] = 'Fantasque Sans Mono:h15',
}

---@type ConfigModule
local module = {
  hooks = {
    init = function(state)
      if vim.g.neovide then
        vim.o.guifont = fonts.fantasque
        vim.g.neovide_scroll_animation_length = 0.1
        vim.g.neovide_cursor_animation_length = 0
      end
    end,
  },
}

return module
