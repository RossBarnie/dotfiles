return {
  {
    'AlexvZyl/nordic.nvim',
    lazy = false,
    priority = 1000,
    branch = "main",
    config = function()
      require('nordic').load({
        on_highlight = function(highlights, palette)
          highlights.NeoTreeGitUntracked = { fg = palette.magenta.dim }
        end
      })
    end
  },
  {
    'w0ng/vim-hybrid',
    lazy = false
  },
  'nordtheme/vim',
}
