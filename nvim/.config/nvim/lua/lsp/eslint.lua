local M = {}

local base_on_attach = vim.lsp.config.eslint.on_attach

function M.on_attach(client, bufnr)
  if not base_on_attach then return end

  base_on_attach(client, bufnr)
  vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = bufnr,
    command = "LspEslintFixAll",
  })
end

return M
