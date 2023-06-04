---@type ConfigModule
local module = {
  pkgs = {
    -- Plugins that run in the background (no config needed)
    -- or are implemented with vimscript and use vim commands bound to keys
    { 'famiu/bufdelete.nvim' },
    { 'sindrets/winshift.nvim' },
    { 'tpope/vim-sleuth' },
    { 'tpope/vim-repeat' },
  },
}

return module
