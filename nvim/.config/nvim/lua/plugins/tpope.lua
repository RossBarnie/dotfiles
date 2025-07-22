local k = function(lhs, rhs)
  vim.keymap.set('n', lhs,rhs)
end

return {
  'tpope/vim-surround', -- Add 'surround' commands, eg cs'
  'tpope/vim-endwise', -- automatically add `end` to ruby blocks
  {
    'tpope/vim-fugitive', -- Git in vim
    config = function()
      k('<leader>gs', ':G<CR>')
      k('<leader>gc', ':G commit<CR>')
      k('<leader>gb', ':G blame<CR>')
      k('<leader>gd', ':Gdiffsplit!<CR>')
      k('<leader>gp', ':G push') -- no <CR> as a "confirm"
      k('<leader>gl', ':G pull')
      vim.api.nvim_create_autocmd({"BufReadPost"}, {
        pattern = { "fugitive://*" },
        command = "set bufhidden=delete",
      }) -- automatically close fugitive buffers when they are hidden
    end
  },
}
