return {
  wakatime = {
    enabled = true,
  },
  font = {
    name = 'Berkeley Mono',
    size = '12',
  },
  startuptime = {
    enabled = true,
  },
  tree = {
    hidden = {
      '.DS_Store',
      'thumbs.db',
      'node_modules',
    },
  },
  discord = {
    blacklist = {}
  },
  mason = {
    packages = {
      -- Packages to be installed automatically by mason

      -- Format
      -- None

      -- Lint
      'gitlint',

      -- LSP
      -- 'lua-language-server',
      'typescript-language-server',
      -- 'gopls',
      'bash-language-server',
      'omnisharp',
      'rnix-lsp',
      'json-lsp'

      -- DAP
      -- None
    },
  },
}
