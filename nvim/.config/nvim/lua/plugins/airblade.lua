return {
  'airblade/vim-gitgutter', -- git diff as signs in sign column
  {
    'airblade/vim-rooter', -- git diff as signs in sign column
    config = function()
      vim.g.rooter_cd_cmd = 'lcd'
    end
  }
}
