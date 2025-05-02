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
  }
}
