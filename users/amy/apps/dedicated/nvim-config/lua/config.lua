local home = vim.fn.expand("$HOME") .. "/code/"

return {
  wakatime = {
    enabled = true,
  },
  font = {
    name = 'Berkeley Mono',
    size = '12',
  },
  startuptime = {
    enabled = false,
  },
  tree = {
    hidden = {
      '.DS_Store',
      'thumbs.db',
      'node_modules',
    },
  },
  discord = {
    blacklist = {
      [vim.fn.resolve(home .. "private")] = "shhh, private business!",
    }
  },
}
