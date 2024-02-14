return {
  {
    'ms-jpq/coq_nvim',
    branch = 'coq',
    init = function()
      vim.g.coq_settings = {
        auto_start = 'shut-up',
        keymap = {
          bigger_preview = '',
          jump_to_mark = ''
        }
      }
    end
  }
}
