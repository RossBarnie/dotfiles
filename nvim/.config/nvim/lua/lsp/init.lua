local k = function(lhs, rhs)
  vim.keymap.set('n', lhs, rhs)
end

local M = {}

function M.setup()

  local capabilities = vim.tbl_deep_extend(
    "force",
    vim.lsp.protocol.make_client_capabilities(),
    require('cmp_nvim_lsp').default_capabilities()
  )

  vim.lsp.config('*', {
    capabilities = capabilities
  })

  local servers = {
    bashls = {},
    eslint = require('lsp.eslint'),
    gopls = {},
    jedi_language_server = require('lsp.jedi'),
    jsonls = require('lsp.jsonls'),
    lua_ls = require('lsp.lua_ls'),
    marksman = {},
    -- ruby_lsp = {},
    ruff = {},
    rust_analyzer = {},
    solargraph = {},
    ts_ls = {},
    yamlls = require('lsp.yamlls'),
  }

  for server, config in pairs(servers) do
    vim.lsp.config(server, config)
    vim.lsp.enable(server)
  end
end

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
k('<leader>dl', vim.diagnostic.setloclist) -- "[d]iagnostic [l]ocallist"

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
    local jump = function(count)
      return function()
        vim.diagnostic.jump({ count = count, float = true })
      end
    end

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', ']d', jump(1), opts)
    vim.keymap.set('n', '[d', jump(-1), opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

vim.diagnostic.config(
  {
    virtual_text = {
      spacing = 4,
    },
    underline = true,
    severity_sort = true,
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = "",
        [vim.diagnostic.severity.WARN] = "",
        [vim.diagnostic.severity.HINT] = "",
        [vim.diagnostic.severity.INFO] = ""
      }
    }
  }
)

return M
