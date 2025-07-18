local M = {}

function M.root_dir(startpath)
  vim.fs.dirname(vim.fs.find('.git', { path = startpath, upward = true })[1])
end

return M
