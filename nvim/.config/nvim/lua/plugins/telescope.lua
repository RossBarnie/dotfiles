return {
  'nvim-telescope/telescope.nvim',
  config = function()
    local telescope = require("telescope")
    telescope.setup {
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
  keys = {
    { '<Leader><CR>', ':Telescope repo list<CR>' },
    { '<Leader>d', ':Telescope lsp_definitions<CR>' },
    { '<Leader>f', ':Telescope live_grep<CR>' },
    { '<Leader>gs', ':Telescope git_status<CR>' },
    { '<C-p>', ':Telescope find_files<CR>' },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'cljoly/telescope-repo.nvim',
  },
}
