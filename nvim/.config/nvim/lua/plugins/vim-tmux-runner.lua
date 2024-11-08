-- Run arbitrary commands in another tmux pane
return {
  {
    'christoomey/vim-tmux-runner',
    keys = {
      { "<leader>tr", "<cmd>VtrSendCommandToRunner<cr>", desc = "Run command in attached tmux pane ([t]est [r]unner)" },
      { "<leader>ta", "<cmd>VtrAttachToPane<cr>", desc = "Attach runner to tmux pane ([t]est runner [a]ttach)" },
    }
  }
}
