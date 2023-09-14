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
    end
  },
}
