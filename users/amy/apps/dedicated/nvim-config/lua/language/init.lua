return {
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
}
