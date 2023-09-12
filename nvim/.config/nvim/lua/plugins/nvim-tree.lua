return {
  'nvim-tree/nvim-tree.lua',
  config = function ()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    require("nvim-tree").setup {
      renderer = {
        icons = {
          show = {
            file = false,
            folder = false,
            folder_arrow = false,
            git = false
          }
        }
      }
    }
  end,
  keys = {
    { '<C-n>', ':NvimTreeToggle<CR>' }
  }
}