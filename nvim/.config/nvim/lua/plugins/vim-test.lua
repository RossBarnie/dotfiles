return {
  {
    "vim-test/vim-test",
    version = "*",
    keys = {
      { "<leader>tt", "<cmd>TestNearest<CR>", desc = "Run nearest test" },
    },
    init = function ()
      vim.g["test#strategy"] = "vtr"
      vim.g["test#ruby#use_binstubs"] = 0
    end
  }
}
