return {
  "ellisonleao/glow.nvim",
  config = function ()
    require("glow").setup{}
  end,
  keys = {
    { '<Leader>md', ':Glow<CR>' }
  }
}
