-- Protected in case the module is broken, or something
-- We need it to load modules safely
local ok, utils = pcall(require, 'utils')
if not ok then
  return vim.notify_once('Failed to load `utils` module, cannot proceed.')
end

local module = utils.load_module

-- Bootstrap Lazy
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system { 'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', lazypath }
    vim.fn.system { 'git', '-C', lazypath, 'checkout', 'tags/stable' } -- last stable release
  end
end

vim.opt.rtp:prepend(lazypath)

-- Do not source the default filetype.vim, we do that ourselves
vim.g.did_load_filetypes = 1

-- Core config
module('core/editor')
module('core/autocmd')
module('core/keybinds')

-- Neovide, if it exists
module('core/neovide')

-- Init Lazy
require('lazy').setup({
  -- Packages
  {
    'folke/lazy.nvim',
    priority = 60,
    init = function()
      -- HACK: Find a more stable way to configure these.
      -- This hacks on lazy internals which is not good.
      -- Doing this also makes the UI inaccurate, as it still
      -- displays the old binds in the help area.
      local keys = require('lazy.view.config').keys
      keys.profile_sort = '<C-g>'
    end,
  },

  module('theming/colours'),

  -- Core features
  module('core/statusline'),
  module('core/sessions'),

  -- Language features and navigation
  module('util/ui/tree'),
  module('language'),
  module('language/packages'),

  -- Snippets must be loaded before cmp
  module('util/integrations/snippets'),
  module('language/misc/cmp'),

  -- Plugins
  module('treesitter'),

  -- Util
  module('util/compile'),
  module('util/filetype'),
  module('util/startuptime'),

  module('util/navigation/leap'),
  module('util/navigation/scroll'),

  module('util/ui/gui'),
  module('util/ui/terminal'),
  module('util/ui/cheatsheet'),
  module('util/ui/numb'),
  module('util/ui/telescope'),

  module('util/integrations/git'),
  module('util/integrations/discord'),
  module('util/integrations/wakatime'),

  module('util/text/autopairs'),
  module('util/text/surround'),
  module('util/text/comment'),
  module('util/text/neogen'),
  module('util/text/todo'),
  module('util/text/cutlass'),
  module('util/text/colorizer'),
  module('util/text/autosave'),
  module('util/text/debugprint'),
  module('util/text/wordmotion'),

  module('util/text/icons'),

  -- Plugins that run in the background (no config needed)
  -- or are implemented with vimscript and use vim commands bound to keys
  { 'famiu/bufdelete.nvim' },
  { 'sindrets/winshift.nvim' },
  { 'tpope/vim-sleuth' },
  { 'tpope/vim-repeat' },
}, {
  -- Configuration
  -- Change lockfile location, default is in ~/.config/, not the git repo that the config is stored in (~/nixos)
  -- Env controlled from the wrapper (../../../../packages/nvim/)
  lockfile = vim.env.NVIM_CONFIG_ROOT .. '/lazy-lock.json',
  change_detection = {
    -- When using an out of store symlink, lazy will be able to detect changes for us
    -- and auto reinstall
    enabled = true,
  },
  install = {
    colorscheme = { 'catppuccin' },
  },
  defaults = {
    lazy = false,
  },
})
