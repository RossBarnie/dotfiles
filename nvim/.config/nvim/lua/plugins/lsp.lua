local k = function(lhs, rhs)
  vim.keymap.set('n', lhs, rhs)
end

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
    version = '*',
    config = function()
      local lsp = require('lspconfig')
      local capabilities = vim.tbl_deep_extend("force",
        vim.lsp.protocol.make_client_capabilities(),
        require('cmp_nvim_lsp').default_capabilities()
      )
      lsp.rust_analyzer.setup {
        capabilities = capabilities,
      }
      lsp.eslint.setup {
        capabilities = capabilities,
        on_attach = function(_, bufnr)
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll"
          })
        end,
      }
      lsp.solargraph.setup {
        capabilities = capabilities,
      }
      lsp.ruby_lsp.setup {
        capabilities = capabilities,
      }
      lsp.marksman.setup {
        capabilities = capabilities,
      }
      lsp.yamlls.setup {
        capabilities = capabilities,
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
      }
      lsp.jedi_language_server.setup{
        capabilities = capabilities,
        root_dir = function (startpath)
          vim.fs.dirname(vim.fs.find('.git', { path = startpath, upward = true })[1])
        end
      }
      lsp.lua_ls.setup {
        capabilities = capabilities,
        on_init = function(client)
          local path = client.workspace_folders[1].name
          if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
            client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
              Lua = {
                runtime = {
                  -- Tell the language server which version of Lua you're using
                  -- (most likely LuaJIT in the case of Neovim)
                  version = 'LuaJIT'
                },
                -- Make the server aware of Neovim runtime files
                workspace = {
                  checkThirdParty = false,
                  library = {
                    vim.env.VIMRUNTIME
                    -- "${3rd}/luv/library"
                    -- "${3rd}/busted/library",
                  }
                  -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                  -- library = vim.api.nvim_get_runtime_file("", true)
                },
              }
            })
            client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
          end
          return true
        end,
        settings = {
          Lua = {
            diagnostics = {
              globals = {
                'vim'
              }
            }
          }
        }
      }
      lsp.bashls.setup {
        capabilities = capabilities,
      }
      lsp.ts_ls.setup {
        capabilities = capabilities
      }
      lsp.ruff.setup {
        capabilities = capabilities
      }
      lsp.gopls.setup {
        capabilities = capabilities
      }
      lsp.jsonls.setup {
        capabilities = capabilities,
        settings = {
          json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
          }
        }
      }
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
    end
  }
}
