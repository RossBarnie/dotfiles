return {
  {
    'AlexvZyl/nordic.nvim',
    lazy = false,
    config = function()
      local palette = require('nordic.colors')
      require('nordic').setup {
        override = {
          NeoTreeGitUntracked = { fg = palette.magenta.dim },
        }
      }
    end
  },
  {
    'w0ng/vim-hybrid',
    lazy = false
  },
  'nordtheme/vim',
}
