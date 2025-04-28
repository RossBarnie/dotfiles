return {
  {
    'folke/trouble.nvim',
    opts = {},
    cmd = "Trouble",
    keys = {
      {
        "<leader>do",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Loclist toggle (Trouble)"
      },
      {
        "<leader>to",
        "<cmd>Trouble symbols toggle<cr>",
        desc = "Symbols toggle (Trouble)"
      },
    }
  }
}

