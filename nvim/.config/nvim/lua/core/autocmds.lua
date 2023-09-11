-- markdown settings
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "markdown",
  callback = function ()
    vim.o.wrap = true
    vim.o.spell = true
    vim.o.textwidth = 0
    vim.o.list = false
    vim.o.linebreak = true
  end
})
