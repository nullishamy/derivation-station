-- For reference: https://github.com/nullishamy/derivation-station/blob/d691169ba04d9372290f1bdde5a3adbb27798c8f/users/amy/apps/dedicated/nvim-config/init.lua

require('lib').modules {
  'neovide',

  'editor.settings',
  'editor.direnv',
  'editor.keys',
  'editor.project',
  'editor.autocmd',

  'navigation.scroll',
  'navigation.pairs',

  'visual.statusline',
  'visual.central',
  'visual.theme',

  'treesitter',

  'interface.tree',
  'interface.snippets',
  'interface.cmp',
  'interface.telescope',

  'text.icons',
  'text.todo',
  'text.surround',
  'text.comment',
  'text.indent',
  'text.cutlass',
  'text.autosave',

  'background',
  'lazy',
}
