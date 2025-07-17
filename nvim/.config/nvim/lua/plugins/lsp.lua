return {
  {
    'mason-org/mason.nvim',
    version = '*',
    config = function()
      require('mason').setup {
        PATH = 'append'
      }
    end
  },
  {
    'neovim/nvim-lspconfig',
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      'b0o/schemastore.nvim'
    },
    version = '*'
  }
}
