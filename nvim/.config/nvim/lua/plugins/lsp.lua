local k = function(lhs, rhs)
  vim.keymap.set('n', lhs, rhs)
end

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
    config = function()
      k('<space>e', vim.diagnostic.open_float)
      k('[d', vim.diagnostic.goto_prev)
      k(']d', vim.diagnostic.goto_next)
      k('<space>q', vim.diagnostic.setloclist)

      local lsp = require('lspconfig')
      lsp.rust_analyzer.setup {
        settings = {
          ['rust-analyzer'] = {},
        }
      }
      lsp.quick_lint_js.setup {
        filetypes = { 'javascript', 'javascriptreact' },
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
