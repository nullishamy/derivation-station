return {
  {
    'neovim/nvim-lspconfig',
    config = function()
      -- Run the pre-setup system
      require('language.impl._before')

      local lsp_config = require('lspconfig')
      local format_config = {}

      local capabilities = require('language.misc.capabilities')
      local languages = require('language.impl._collect')

      for _, module in pairs(languages) do
        local is_enabled = module.enabled

        if is_enabled then
          local servers, formatters = module.servers, module.formatters

          for _, server in pairs(servers) do
            if server.before then
              server.before(module)
            end

            if server.configure_with == 'lspconfig' then
              local config = server.overrides or {}
              local on_attach = require('language.misc.on_attach')(module)

              config.autostart = true
              config.capabilities = capabilities
              config.on_attach = on_attach

              lsp_config[server.declared_config.name].setup(config)
            elseif server.configure_with == 'external' then
              server.setup(module)
            end

            if server.after then
              server.after(module)
            end
          end

          for _, formatter in pairs(formatters) do
            if formatter.configure_with == 'null-ls' then
              table.insert(format_config, formatter.source)
            elseif formatter.configure_with == 'lsp' then
              vim.pretty_print(formatter, 'lsp fmt')
            end
          end
        else
          print(('[lang] %s disabled'):format(module.name))
        end
      end

      -- Install null-ls formatter configs
      -- TODO: Verify that doing this won't override other sources
      require('null-ls').register(format_config)

      -- Run the post-setup system
      require('language.impl._after')
    end,
    dependencies = {
      { 'jose-elias-alvarez/null-ls.nvim' },
      { 'nullishamy/zeppelin.nvim' },
      { 'simrat39/rust-tools.nvim' },
      { 'alaviss/nim.nvim' },
    },
  },
  {
    'DNLHC/glance.nvim',
    config = function()
      local glance = require('glance')
      local actions = glance.actions

      glance.setup {
        height = 18, -- Height of the window
        zindex = 45,

        -- Or use a function to enable `detached` only when the active window is too small
        -- (default behavior)
        detached = function(winid)
          return vim.api.nvim_win_get_width(winid) < 100
        end,

        preview_win_opts = { -- Configure preview window options
          cursorline = true,
          number = true,
          wrap = true,
        },
        border = {
          enable = false, -- Show window borders. Only horizontal borders allowed
          top_char = '―',
          bottom_char = '―',
        },
        list = {
          position = 'right', -- Position of the list window 'left'|'right'
          width = 0.33, -- 33% width relative to the active window, min 0.1, max 0.5
        },
        theme = { -- This feature might not work properly in nvim-0.7.2
          enable = true, -- Will generate colors for the plugin based on your current colorscheme
          mode = 'auto', -- 'brighten'|'darken'|'auto', 'auto' will set mode based on the brightness of your colorscheme
        },
        mappings = {
          list = {
            ['j'] = actions.next, -- Bring the cursor to the next item in the list
            ['k'] = actions.previous, -- Bring the cursor to the previous item in the list
            ['<Down>'] = actions.next,
            ['<Up>'] = actions.previous,
            ['<Tab>'] = actions.next_location, -- Bring the cursor to the next location skipping groups in the list
            ['<S-Tab>'] = actions.previous_location, -- Bring the cursor to the previous location skipping groups in the list
            ['<C-u>'] = actions.preview_scroll_win(5),
            ['<C-d>'] = actions.preview_scroll_win(-5),
            ['v'] = actions.jump_vsplit,
            ['s'] = actions.jump_split,
            ['t'] = actions.jump_tab,
            ['<CR>'] = actions.jump,
            ['o'] = actions.jump,
            ['<leader>l'] = actions.enter_win('preview'), -- Focus preview window
            ['q'] = actions.close,
            ['Q'] = actions.close,
            ['<Esc>'] = actions.close,
            -- ['<Esc>'] = false -- disable a mapping
          },
          preview = {
            ['Q'] = actions.close,
            ['<Tab>'] = actions.next_location,
            ['<S-Tab>'] = actions.previous_location,
            ['<leader>l'] = actions.enter_win('list'), -- Focus list window
          },
        },
        hooks = {
          -- Don't open glance when there is only one result and it is located in the current buffer, open otherwise
          before_open = function(results, open, jump)
            local uri = vim.uri_from_bufnr(0)
            if #results == 1 then
              local target_uri = results[1].uri or results[1].targetUri

              if target_uri == uri then
                jump(results[1])
              else
                open(results)
              end
            else
              open(results)
            end
          end,
        },
        folds = {
          fold_closed = '',
          fold_open = '',
          folded = true, -- Automatically fold list on startup
        },
        indent_lines = {
          enable = true,
          icon = '│',
        },
        winbar = {
          enable = true, -- Available strating from nvim-0.8+
        },
      }
    end,
  },
}
