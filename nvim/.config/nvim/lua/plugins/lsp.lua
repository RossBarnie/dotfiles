return {
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup{}
    end
  },
  {
    'neovim/nvim-lspconfig',
    event = { 'BufEnter', 'BufNewFile' },
    keys = {
      { '<space>e', vim.diagnostic.open_float },
      { '[d', vim.diagnostic.goto_prev },
      { ']d', vim.diagnostic.goto_next },
      { '<space>q', vim.diagnostic.setloclist },
    },
    config = function()
      local lsp = require('lspconfig')
      lsp.rust_analyzer.setup {
        settings = {
          ['rust-analyzer'] = {},
        }
      }
      lsp.quick_lint_js.setup {
        handlers = {
          ['textDocument/publishDiagnostics'] = vim.lsp.with(
            vim.lsp.diagnostic.on_publish_diagnostics, {
              update_in_insert = true
            }
          )
        }
      }
      lsp.solargraph.setup {}
      lsp.marksman.setup {}
      lsp.yamlls.setup {
        settings = {
          yaml = {
            schemastore = {
              enable = false
            },
            schemas = require('schemastore').yaml.schemas(),
          }
        }
      }
    end
  }
}
