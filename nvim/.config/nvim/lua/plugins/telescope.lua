local k = function(lhs,rhs)
  vim.keymap.set('n', lhs, rhs)
end
return {
  'nvim-telescope/telescope.nvim',
  config = function()
    local telescope = require("telescope")
    k('<Leader>fp', ':Telescope repo list<CR>') -- find project
    k('<Leader>fd', ':Telescope lsp_definitions<CR>') -- find definition
    k('<Leader>fs', ':Telescope live_grep<CR>') -- find string
    k('<Leader>fb', ':Telescope buffers<CR>') -- find buffer
    k('<Leader>ff', ':Telescope find_files<CR>') -- find files
    k('<Leader>fh', ':Telescope help_tags<CR>') -- find help (vim)
    k('<Leader>fm', ':Telescope man_pages<CR>') -- find help (man)
    telescope.setup {
      defaults = {
        layout_strategy = 'vertical'
      },
      opts = {
        defaults = {
          file_ignore_patterns = { '^node_modules/*', '^.git/*' }
        }
      },
      pickers = {
        find_files = {
          no_ignore = true
        },
        live_grep = {
          glob_pattern = '!.git/*',
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
