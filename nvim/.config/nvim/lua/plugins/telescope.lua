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
    k('<Leader>fj', ':Telescope jsonfly<CR>') -- find json key
    telescope.setup {
      defaults = {
        layout_strategy = 'vertical'
      },
      find_files = {
        hidden = true,
      },
    }
    telescope.load_extension('fzf')
  end,
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    'Myzel394/jsonfly.nvim',
  },
}
