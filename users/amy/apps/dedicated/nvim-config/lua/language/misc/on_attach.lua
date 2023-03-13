return function(_module)
  return function(_, buf)
    local set = function(mode, lhs, rhs, opts)
      opts = vim.tbl_extend('keep', opts or {}, { noremap = true, silent = true, buffer = buf })

      vim.keymap.set(mode, lhs, rhs, opts)
    end

    set('n', '<leader>y', function()
      vim.lsp.buf.format {
        timeout_ms = 10000,
        bufnr = buf,
        filter = function(clnt)
          return clnt.name == 'null-ls'
        end,
      }
    end)

    set('n', 'gD', function()
      vim.lsp.buf.declaration()
    end)
    set('n', 'gd', function()
      vim.cmd([[Glance definitions]])
    end)
    set('n', 'gtd', function()
      vim.cmd([[Glance type_definitions]])
    end)
    set('n', 'gi', function()
      vim.cmd([[Glance implementations]])
    end)
    set('i', '<C-a>', function()
      vim.lsp.buf.signature_help()
    end)
    set('n', '<C-a>', function()
      vim.lsp.buf.signature_help()
    end)
    set('n', '<leader>wa', function()
      vim.lsp.buf.add_workspace_folder()
    end)
    set('n', '<leader>wr', function()
      vim.lsp.buf.remove_workspace_folder()
    end)
    set('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end)
    set('n', '<leader>rn', function()
      vim.lsp.buf.rename()
    end)
    set('n', 'gr', function()
      vim.cmd([[Glance references]])
    end)
    set('', '<leader>ca', function()
      vim.lsp.buf.code_action()
    end)

    set('', '<Leader>n', function()
      vim.diagnostic.goto_next()
    end)
    set('', '<Leader>p', function()
      vim.diagnostic.goto_prev()
    end)
    set('', '<C-d>', function()
      vim.diagnostic.open_float(nil, { focus = true, scope = 'line' })
    end)
    set('n', '<C-Space>', function()
      vim.lsp.buf.hover()
    end)
  end
end
