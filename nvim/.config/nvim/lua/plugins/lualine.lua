return {
  {
    'linrongbin16/lsp-progress.nvim',
    config = function()
      require('lsp-progress').setup()
    end
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      'linrongbin16/lsp-progress.nvim'
    },
    config = function()
      require("lualine").setup {
        sections = {
          lualine_c = { require('lsp-progress').progress }
        },
        options = {
          icons_enabled = false,
          theme = 'nordic'
        },
        extensions = {
          'fugitive'
        }
      }
    end
  }
}
