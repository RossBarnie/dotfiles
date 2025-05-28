return {
  "nvim-neorg/neorg",
  lazy = false,
  version = "*",
  config = true,
  opts = {
    load = {
      ["core.defaults"] = {},
      ["core.dirman"] = {
        config = {
          workspaces = {
            notes = "~/projects/personal/notes",
          },
          default_workspace = "notes",
        }
      },
      ["core.concealer"] = {}
    }
  },
  keys = {
    { "<leader>nj", "<cmd>Neorg journal today<cr>", desc = "[N]eorg [j]ournal" },
    { "<leader>nn", "<cmd>Neorg index<cr>", desc = "Open [N]eorg [n]otes" },
  }
}
