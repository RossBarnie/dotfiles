local k = function(lhs, rhs)
  vim.keymap.set('n', lhs, rhs)
end

return {
  'nvim-tree/nvim-tree.lua',
  config = function ()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    require("nvim-tree").setup {}
    k('<C-n>', ':NvimTreeToggle<CR>')
  end,
}
