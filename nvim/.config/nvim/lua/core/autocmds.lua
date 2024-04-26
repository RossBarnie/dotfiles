vim.api.nvim_create_augroup("vimrc", { clear = true })
vim.api.nvim_create_autocmd({"VimResized"}, {
  pattern = { "*" },
  command = ":wincmd =",
})
