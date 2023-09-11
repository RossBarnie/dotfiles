local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
-- there's a better way to do this, see https://github.com/folke/lazy.nvim#-structuring-your-plugins
require("lazy").setup(
  {
    { 'AlexvZyl/nordic.nvim', lazy = true }, -- colorscheme
    'christoomey/vim-tmux-navigator',       -- tmux pane movement matches vim pane movement (C-h/j/k/l)
    'tpope/vim-surround', -- Add 'surround' commands, eg cs'
    'tpope/vim-fugitive', -- Git in vim
    'airblade/vim-gitgutter', -- git diff as signs in sign column
    'chr4/nginx.vim', -- nginx file support
    { 'nvim-tree/nvim-tree.lua', config = require("plugins.nvim-tree").config }, -- File explorer
    { 'nvim-lualine/lualine.nvim', config = require("plugins.lualine").config }, -- Faster Airline
    { 'nvim-telescope/telescope.nvim',
      config = require("plugins.telescope").config,
      dependencies = require("plugins.telescope").dependencies }, -- fuzzy finder framework, requires ripgrep
  },
  {
    root = vim.fn.stdpath("data") .. "site"
  }
)
