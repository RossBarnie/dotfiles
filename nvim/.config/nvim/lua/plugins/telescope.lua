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
      defaults = {
        layout_strategy = 'vertical'
      },
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
    }
  end,
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
}
