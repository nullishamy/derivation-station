return {
  name = 'rust',

  lsp = {
    {
      key = 'rust_analyzer',
      config = {
        cmd = { 'rust-analyzer' },
        post_init = function(config)
          require('rust-tools').setup({
            server = {
              autostart = true,
              on_attach = config.on_attach,
              capabilities = config.capabilities,
            },
            tools = {
              inlay_hints = {
                auto = false,
              },
            },
          })
        end,
      },
    },
  },

  format = {
    filetype = 'rust',
    runners = {
      require('formatter.filetypes.rust').rustfmt,
    }
  },
}
