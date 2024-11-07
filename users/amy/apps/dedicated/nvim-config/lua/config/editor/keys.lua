local function abbrev(from, to, opts)
  -- This API is only available from nvim 0.7 and up.
  -- Setting abbreviations without it is tedious so we wont bother
  if not vim.api.nvim_create_user_command then
    return vim.api.notify_once('Abbreviations are only available in nvim 0.7 and newer, please update.')
  end

  local options = { nargs = 0 }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end

  vim.api.nvim_create_user_command(from, to, options)
end

---@type ConfigModule
local module = {
  pkgs = {
    {
      'Nexmean/caskey.nvim',
      config = function()
        local ck = require('caskey')

        --Remap space as leader key
        vim.g.mapleader = ' '
        vim.g.maplocalleader = ' '

        ck.setup {
          mode = { 'n', 'v' },

          -- Noop q: as it's an annoying typo and the feature isnt used
          ['q:'] = { act = '<Nop>' },
          ['<Space>'] = { act = '<Nop>' },

          -- Telescope & tree
          ['<leader>f'] = {
            ['f'] = { act = ck.cmd('Telescope smart_open path_display={"truncate"}') },
            ['o'] = { act = ck.cmd('Telescope buffers path_display={"truncate"}') },
            ['h'] = { act = ck.cmd('Telescope help_tags path_display={"truncate"}') },
            ['g'] = { act = ck.cmd('Telescope live_grep path_display={"truncate"}') },
            ['r'] = { act = ck.cmd('Telescope resume') },

            -- Cheatsheet
            ['c'] = { act = ck.cmd('Cheatsheet') },
          },

          -- Quick exit from insert mode
          ['jk'] = {
            act = '<Esc>',
            mode = 'i',
          },

          ['J'] = {
            act = '10j',
            mode = { 'n', 'v', 'o' },
          },
          ['K'] = {
            act = '10k',
            mode = { 'n', 'v', 'o' },
          },

          -- Disable arrow keys to force hjkl usage
          ['<Up>'] = { act = '<Nop>' },
          ['<Down>'] = { act = '<Nop>' },
          ['<Left>'] = { act = '<Nop>' },
          ['<Right>'] = { act = '<Nop>' },

          -- Buffer controls
          ['<Leader>q'] = { act = ck.cmd('Bdelete') },

          -- Window controls
          ['<leader>h'] = { act = ck.cmd('wincmd h') },
          ['<leader>j'] = { act = ck.cmd('wincmd j') },
          ['<leader>k'] = { act = ck.cmd('wincmd k') },
          ['<leader>l'] = { act = ck.cmd('wincmd l') },
          ['<C-W>m'] = { act = ck.cmd('WinShift') },

          -- Jump to start / end
          ['H'] = {
            mode = { 'n', 'v', 'x', 'o' },
            act = '^',
          },
          ['L'] = {
            mode = { 'n', 'v', 'x', 'o' },
            act = 'g_',
          }, -- g_ jumps to the last non blank character, avoiding newline,

          -- Hard close vim with ctrl q + q
          ['<C-q>q'] = { act = ck.cmd('qa!') },

          -- Sessions
          ['<leader>s'] = {
            ['l'] = { act = ck.cmd('SessionManager load_session') },
            ['d'] = { act = ck.cmd('SessionManager delete_session') },
            ['s'] = { act = ck.cmd('SessionManager save_current_session') },
          },

          -- Moving lines
          -- Moving up requires two lines for some reason
          ['<C-j>'] = { act = ck.cmd('m +1') },
          ['<C-k>'] = { act = ck.cmd('m -2') },

          -- Tree
          ['<Leader>g'] = { act = ck.cmd('Neotree focus reveal') },

          -- Debugprint
          ['<leader>u'] = {
            ['u'] = {
              act = function()
                return require('debugprint').debugprint()
              end,
            },
            ['q'] = {
              act = function()
                return require('debugprint').debugprint { variable = true }
              end,
            },
            ['Q'] = {
              act = function()
                return require('debugprint').debugprint { above = true, variable = true }
              end,
            },
            ['o'] = {
              act = function()
                return require('debugprint').debugprint { motion = true }
              end,
            },
            ['O'] = {
              act = function()
                return require('debugprint').debugprint { above = true, motion = true }
              end,
            },
          },
          ['<leader>U'] = {
            act = function()
              return require('debugprint').debugprint { above = true }
            end,
          },

          -- nvim-compile integration
          ['<leader>p'] = {
            ['r'] = {
              act = function()
                require('nvim-compile').run()
              end,
            },
            ['v'] = {
              act = function()
                require('nvim-compile').view()
              end,
            },
          },
        }

        -- Abbreviations
        vim.cmd([[ command! -nargs=? Compile unsilent lua require("nvim-compile").run("<args>") ]])

        abbrev('OrganiseImports', function()
          require('language.util').organize_imports()
        end)

        abbrev('Doc', function()
          require('neogen').generate()
        end)

        abbrev('DeleteDebugPrints', function()
          require('debugprint').deleteprints()
        end)

        abbrev('RPDisable', function()
          require('presence'):cancel()
        end)

        abbrev('RPEnable', function()
          require('presence'):connect()
        end)

        abbrev('Bclear', function()
          vim.cmd([[ %bd ]])
        end)
      end,
    },
  },
}

return module
