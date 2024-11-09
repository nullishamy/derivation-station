---@type ConfigModule
local module = {
  pkgs = {
    -- Plugins that run in the background (no config needed)
    -- or are implemented with vimscript and use vim commands bound to keys
    { 'chaoren/vim-wordmotion' },
    { 'famiu/bufdelete.nvim' },
    { 'wakatime/vim-wakatime' },
    { 'sindrets/winshift.nvim' },
    { 'tpope/vim-sleuth' },
    { 'tpope/vim-repeat' },
  },
}

return module
