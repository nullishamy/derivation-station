return {
  'williamboman/mason.nvim',
  config = function ()
    require('mason').setup({
      ui = {
        border = 'rounded',
      },
    })
  end,
  dependencies = {
    {
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      config = function ()
        require('mason-tool-installer').setup({
          ensure_installed = require('config').mason.packages,
          auto_update = false,
          run_on_start = true,
          start_delay = 3000, -- 3 second delay
        })
      end
    }
  },
}

