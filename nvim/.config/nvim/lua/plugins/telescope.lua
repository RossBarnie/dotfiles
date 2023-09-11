local M = {}

M.config = function()
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
end

M.dependencies = {
  'nvim-lua/plenary.nvim',
  'cljoly/telescope-repo.nvim',
}

return M
