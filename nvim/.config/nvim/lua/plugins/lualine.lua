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
        winbar = {
          lualine_a = { 'tabs' },
          lualine_b = { 'filename' }
        },
        inactive_winbar = {
          lualine_a = { 'tabs' },
          lualine_b = { 'filename' }
        },
        options = {
          icons_enabled = false,
          theme = 'nordic',
          always_show_tabline = true
        },
        extensions = {
          'fugitive'
        }
      }
    end
  }
}
