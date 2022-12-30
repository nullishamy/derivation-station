-- Bootstrap Lazy
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({ 'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', lazypath })
    vim.fn.system({ 'git', '-C', lazypath, 'checkout', 'tags/stable' }) -- last stable release
  end
end

vim.opt.rtp:prepend(lazypath)

-- Do not source the default filetype.vim, we do that ourselves
vim.g.did_load_filetypes = 1

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

  -- Dependencies
  { 'MunifTanjim/nui.nvim' },
  { 'nvim-lua/plenary.nvim' },

  -- Theme
  { 'catppuccin/nvim', name = 'catppuccin' },

  -- LSP
  { 'neovim/nvim-lspconfig' },
  { 'williamboman/mason.nvim' },
  { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
  { 'folke/lsp-colors.nvim' },
  { 'jose-elias-alvarez/null-ls.nvim' },
  { 'nullishamy/zeppelin.nvim' },

  -- CMP
  { 'hrsh7th/nvim-cmp' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  { 'saadparwaiz1/cmp_luasnip' },

  -- Treesitter
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
  { 'nvim-treesitter/nvim-treesitter-textobjects' },
  { 'p00f/nvim-ts-rainbow' },
  { 'windwp/nvim-ts-autotag' },
  { 'windwp/nvim-autopairs' },
  { 'nvim-treesitter/playground' },

  -- Languages
  { 'simrat39/rust-tools.nvim' },
  { 'alaviss/nim.nvim' },

  -- Snippets
  { 'honza/vim-snippets' },
  { 'L3MON4D3/LuaSnip' },

  -- Util
  { 'chaoren/vim-wordmotion' },
  { 'uga-rosa/ccc.nvim' },
  { 'numToStr/Comment.nvim' },
  { 'danymat/neogen' },
  { 'nvim-neo-tree/neo-tree.nvim' },
  { 'ggandor/leap.nvim' },
  { 'folke/todo-comments.nvim' },
  { 'karb94/neoscroll.nvim' },
  { 'famiu/bufdelete.nvim' },
  { 'numToStr/FTerm.nvim' },
  { 'sindrets/winshift.nvim' },
  { 'gbprod/cutlass.nvim' },
  { 'nullishamy/nvim-compile' },
  { 'tpope/vim-sleuth' },
  { 'kylechui/nvim-surround' },
  { 'tpope/vim-repeat' },
  { 'nullishamy/autosave.nvim', branch = 'dev' },
  { 'sudormrfbin/cheatsheet.nvim' },
  { 'andrewferrier/debugprint.nvim' },
  { 'linty-org/readline.nvim' },
  { 'nacro90/numb.nvim' },

  -- Formatting
  { 'mhartington/formatter.nvim' },

  -- Misc
  {
    'wakatime/vim-wakatime',
    cond = function()
      return require('config').wakatime.enabled
    end,
  },
  { 'andweeb/presence.nvim' },
  {
    'tweekmonster/startuptime.vim',
    cond = function()
      return require('config').startuptime.enabled
    end,
  },
  { 'nathom/filetype.nvim' },

  -- Selection
  { 'nvim-telescope/telescope.nvim' },
  { 'stevearc/dressing.nvim' },

  -- Statusline
  { 'nvim-lualine/lualine.nvim' },

  -- Git
  { 'lewis6991/gitsigns.nvim' },

  -- Sessions
  { 'Shatur/neovim-session-manager' },

  -- Devicons must be loaded last
  { 'kyazdani42/nvim-web-devicons' },
}, {
  -- Configuration
  -- Change lockfile location, default is r/o on NixOS
  -- Env controlled from the wrapper (../../../../packages/nvim/)
  lockfile = vim.env.NVIM_CONFIG_ROOT .. '/lazy-lock.json',
  change_detection = {
    -- It's r/o on NixOS anyways, no point in checking
    enabled = false,
  },
  install = {
	  -- colorscheme = 'catppuccin',
  },
  defaults = {
    lazy = false,
  },
})
