local k = function(lhs, rhs, desc)
  vim.keymap.set('n', lhs, rhs, { desc = desc })
end

return {
  {
    "ellisonleao/glow.nvim",
    config = function()
      require('glow').setup()
      k('<Leader>md', ':Glow<CR>')
    end
  }
}
