local k = function(lhs, rhs)
  vim.keymap.set('n', lhs,rhs)
end

return {
  'tpope/vim-surround', -- Add 'surround' commands, eg cs'
  'tpope/vim-endwise', -- automatically add `end` to ruby blocks
  {
    'tpope/vim-fugitive', -- Git in vim
    config = function()
      k('<leader>gis', ':G status<CR>')
      k('<leader>gic', ':G commit<CR>')
      k('<leader>gib', ':G blame<CR>')
      k('<leader>gid', ':Gdiffsplit!<CR>')
    end
  },
}
