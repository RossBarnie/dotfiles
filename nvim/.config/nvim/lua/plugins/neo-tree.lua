local k = function(lhs, rhs)
  vim.keymap.set('n', lhs, rhs)
end

return {
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      local nwd = require("nvim-web-devicons")
      nwd.setup {}
      nwd.set_default_icon("", "#6d8086", 66)
    end
  },
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
