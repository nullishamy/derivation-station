---@type ConfigModule
local module = {
  hooks = {
    pre_init = function()
      local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
      if not vim.loop.fs_stat(lazypath) then
        vim.fn.system {
          'git',
          'clone',
          '--filter=blob:none',
          'https://github.com/folke/lazy.nvim.git',
          '--branch=stable', -- latest stable release
          lazypath,
        }
      end
      vim.opt.rtp:prepend(lazypath)
    end,
    init = function(state)
      require('lazy').setup(state.pkgs, {
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
    end,
  },
}

return module
