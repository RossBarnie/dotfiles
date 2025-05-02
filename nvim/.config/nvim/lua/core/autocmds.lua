-- Set up augroup for cleanup
vim.api.nvim_create_augroup("vimrc", { clear = true })

-- Resize nvim on terminal resize
vim.api.nvim_create_autocmd({"VimResized"}, {
  pattern = { "*" },
  command = ":wincmd =",
})

-- Format using LSP on save
vim.api.nvim_create_autocmd({"BufWritePre"}, {
  pattern = { "*" },
  callback = vim.lsp.buf.format,
})
