vim.api.nvim_create_augroup("vimrc", { clear = true })
vim.api.nvim_create_autocmd({"VimResized"}, {
  pattern = { "*" },
  command = ":wincmd =",
})
vim.api.nvim_create_autocmd({"BufWritePre"}, {
  pattern = { "*" },
  callback = vim.lsp.buf.format,
})
vim.api.nvim_create_autocmd('DiagnosticChanged', {
  callback = function()
    vim.diagnostic.setloclist({open = false})
  end,
})
