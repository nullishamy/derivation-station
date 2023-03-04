return {
  'andweeb/presence.nvim',
  config = function()
    function string.starts(self, str)
      return self:find('^' .. str) ~= nil
    end

    local in_blacklist = function(string)
      local blacklist = require('config').discord.blacklist

      for k, v in pairs(blacklist) do
        if string:starts(k) then
          return true, v
        end
      end

      return false, ''
    end

    local conceal = function(activity, info)
      local cur_file = vim.fn.expand('%:p')

      local blacklisted, concealed = in_blacklist(cur_file)

      if blacklisted then
        return concealed
      end

      if info ~= nil then
        return activity .. ' ' .. info
      end
    end

    require('presence'):setup {
      -- General options
      auto_update = true, -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
      neovim_image_text = 'The only good TUI editor', -- Text displayed when hovered over the Neovim image
      main_image = 'file', -- Main image display (either "neovim" or "file")
      log_level = nil, -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
      debounce_timeout = 10, -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
      enable_line_number = false, -- Displays the current line number instead of the current project
      blacklist = {}, -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
      buttons = function(buffer)
        local blacklisted, _ = in_blacklist(buffer)

        if blacklisted then
          return nil
        end

        local git_url_cmd = 'git config --get remote.origin.url'

        -- Trim and coerce empty string value to null
        local repo_url = vim.trim(vim.fn.system(git_url_cmd))

        return { { label = 'View Repository', url = repo_url } }
      end, -- Configure Rich Presence button(s), either a boolean to enable/disable, a static table (`{{ label = "<label>", url = "<url>" }, ...}`, or a function(buffer: string, repo_url: string|nil): table)
      file_assets = {}, -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)

      -- Rich Presence text options
      editing_text = function(s)
        return conceal('Editing', s)
      end,
      reading_text = function(s)
        return conceal('Reading', s)
      end,
      file_explorer_text = function(s)
        return conceal('Browsing', s)
      end,
      workspace_text = function(s)
        return conceal('Working in', s)
      end,

      git_commit_text = 'Committing changes',
      plugin_manager_text = 'Managing plugins',
      line_number_text = 'Line %s out of %s',
    }
  end,
}
