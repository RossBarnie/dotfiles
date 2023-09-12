local k = vim.keymap
k.set('n', '<Leader><CR>', ':Telescope repo list<CR>')
k.set('n', '<Leader>d', ':Telescope lsp_definitions<CR>')
k.set('n', '<Leader>f', ':Telescope live_grep<CR>')
k.set('n', '<Leader>gs', ':Telescope git_status<CR>')
k.set('n', '<C-p>', ':Telescope find_files<CR>')
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
  dependencies = {
    'nvim-lua/plenary.nvim',
    'cljoly/telescope-repo.nvim',
  },
}
