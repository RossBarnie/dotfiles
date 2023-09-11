local M = {}

M.config = function()
  require("lualine").setup {
    options = {
      icons_enabled = false,
      theme = 'nordic'
    },
    -- extensions = {
    --   'fugitive'
    -- }
  }
end

return M
