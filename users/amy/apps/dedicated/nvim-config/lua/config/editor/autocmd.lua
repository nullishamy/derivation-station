---@type ConfigModule
local module = {
  hooks = {
    init = function()
      -- Line numbers should be relative in normal mode
      -- but absolute in insert mode.
      vim.cmd([[ 
                :augroup NumberToggle 
                :  autocmd!
                :  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
                :  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
                :augroup END
            ]])

      -- Don't auto comment new lines
      vim.cmd([[ 
                autocmd BufEnter * set fo-=c fo-=r fo-=o 
            ]])

      -- Disable annoying autoindent rules
      vim.cmd([[
                autocmd BufEnter,WinEnter,FocusGained * set inde=
            ]])

      -- Disable highlight searching for every buffer
      vim.cmd([[
                autocmd BufEnter,WinEnter,FocusGained * set nohlsearch
            ]])
    end,
  },
}

return module
