local k = function(lhs, rhs)
  vim.keymap.set('n', lhs, rhs)
end

local capabilities = vim.tbl_deep_extend("force",
  vim.lsp.protocol.make_client_capabilities(),
  require('cmp_nvim_lsp').default_capabilities()
)

vim.lsp.config('*', {
  capabilities = capabilities
})

local base_on_attach = vim.lsp.config.eslint.on_attach

local servers = {
  bashls = {},
  eslint = {
    on_attach = function(client, bufnr)
      if not base_on_attach then return end

      base_on_attach(client, bufnr)
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        command = "LspEslintFixAll",
      })
    end,
  },
  gopls = {},
  jedi_language_server = {
    root_dir = function (startpath)
      vim.fs.dirname(vim.fs.find('.git', { path = startpath, upward = true })[1])
    end
  },
  jsonls = {
    settings = {
      json = {
        schemas = require('schemastore').json.schemas(),
        validate = { enable = true },
      }
    }
  },
  lua_ls = {
    on_init = function(client)
      if client.workspace_folders then
        local path = client.workspace_folders[1].name
        if
          path ~= vim.fn.stdpath('config')
          and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
        then
          return
        end
      end

      client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
        runtime = {
          -- Tell the language server which version of Lua you're using (most
          -- likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
          -- Tell the language server how to find Lua modules same way as Neovim
          -- (see `:h lua-module-load`)
          path = {
            'lua/?.lua',
            'lua/?/init.lua'
          },
        },
        -- Make the server aware of Neovim runtime files
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME
            -- Depending on the usage, you might want to add additional paths
            -- here.
            -- '${3rd}/luv/library'
            -- '${3rd}/busted/library'
          }
          -- Or pull in all of 'runtimepath'.
          -- NOTE: this is a lot slower and will cause issues when working on
          -- your own configuration.
          -- See https://github.com/neovim/nvim-lspconfig/issues/3189
          -- library = {
          --   vim.api.nvim_get_runtime_file('', true),
          -- }
        },
        diagnostics = {
          globals = {
            "vim",
          }
        }
      })
    end,
    settings = {
      Lua = {}
    }
  },
  marksman = {},
  ruby_lsp = {},
  ruff = {},
  rust_analyzer = {},
  solargraph = {},
  ts_ls = {},
  yamlls = {
    settings = {
      yaml = {
        schemastore = {
          enable = false
        },
        schemas = require('schemastore').yaml.schemas(),
      },
      redhat = {
        telemetry = {
          enabled = false
        }
      }
    }
  },
}

for server, config in pairs(servers) do
  vim.lsp.config(server, config)
  vim.lsp.enable(server)
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

-- Old config override for eslint since for some reason the on_attach just doesn't work for me in the new config
-- Same problem as https://github.com/neovim/nvim-lspconfig/issues/3837
-- local lspconfig = require("lspconfig")
-- lspconfig.eslint.setup({
--   on_attach = function(_, bufnr)
--     vim.api.nvim_create_autocmd("BufWritePre", {
--       buffer = bufnr,
--       command = "EslintFixAll",
--     })
--   end,
-- })
