local k = function(lhs,rhs)
  vim.keymap.set('n', lhs, rhs)
end
return {
  'nvim-telescope/telescope.nvim',
  config = function()
    local telescope = require("telescope")
    k('<Leader><CR>', ':Telescope repo list<CR>')
    k('<Leader>d', ':Telescope lsp_definitions<CR>')
    k('<Leader>f', ':Telescope live_grep<CR>')
    k('<C-p>', ':Telescope find_files<CR>')
    telescope.setup {
      opts = {
        defaults = {
          file_ignore_patterns = { 'node_modules', '.git' }
        }
      },
      pickers = {
        find_files = {
          hidden = true
        },
        live_grep = {
          glob_pattern = '!.git/',
          additional_args = function()
            return { "--hidden" }
          end
        },
      },
      extensions = {
        repo = {
          list = {
            search_dirs = {
              "~/projects"
            }
          }
        }
      }
    }
    telescope.load_extension "repo"
  end,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'cljoly/telescope-repo.nvim',
  },
}
