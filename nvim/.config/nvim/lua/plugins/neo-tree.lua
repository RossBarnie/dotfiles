local k = function(lhs, rhs)
  vim.keymap.set('n', lhs, rhs)
end

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup {
        filesystem = {
          filtered_items = {
            hide_dotfiles = false
          }
        }
      }
      k('<C-n>', ':Neotree reveal<CR>')
    end
  }
}
