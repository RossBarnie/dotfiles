local opt = vim.opt
local g = vim.g

--- globals ---
g.fuzzy_ignore = "*.png;*.PNG;*.JPG;*.jpg;*.GIF;*.gif;vendor/**;coverage/**;tmp/**;rdoc/**;*.sql;_build/**"

--- options ---
opt.listchars = { -- show invisibles
  tab = ">-",
  trail = "-",
  nbsp = "+",
  leadmultispace = "·"
}
opt.lazyredraw = true -- screen not redrawn while executing macros
opt.list = false -- show invisibles
opt.number = true -- show line numbers
opt.laststatus = 3 -- always show status line
opt.title = true -- change title of terminal (if supported)
opt.hlsearch = true -- highlight search results
opt.showtabline = 0 -- never show tabline (handled by Lualine)
opt.expandtab = true -- use spaces not tabs
opt.tabstop = 2 -- 2 spaces for tab indenting
opt.softtabstop = 2 -- 2 spaces for space indenting
opt.shiftwidth = 2 -- use 2 spaces in autoindenting
opt.wrap = false -- don't wrap long lines
opt.backspace = { "indent", "eol", "start" } -- backspace can navigate over EOL and indents
opt.autoindent = true -- copy indent from previous line when starting a new one
opt.copyindent = true -- copy indent format (eg tabs, spaces) when starting a new line
opt.smartcase = true -- use smartcase when searching
opt.incsearch = true -- use incremental searching (show results as you type)
opt.history = 500
opt.undolevels = 500
opt.visualbell = true -- use a visual bell, not a beep, on error
opt.backup = false -- don't keep backups of current file
opt.wildmenu = true -- enhanced tab completion for new files
opt.colorcolumn = "135"
opt.autoread = true -- automatically read files changed on disk
opt.cursorline = true -- highlight the current line of the cursor
opt.termguicolors = true
opt.timeoutlen = 1000
opt.ttimeoutlen = 0
opt.showcmd = true
opt.swapfile = false -- no swap
opt.background = "dark"
opt.showmode = false -- don't show the mode as Airline is doing it
opt.splitbelow = true -- hsplit creates split below current
opt.splitright = true -- vsplit creates split to the right of current
opt.shiftround = true -- round indent to multiple of shiftwidth
opt.spell = false -- disable spell check by default
opt.mouse = "a" -- enable mouse use, I like it for switching contexts (browser to terminal)
opt.signcolumn = "yes" -- add signcolumn for git gutter and LSP
opt.updatetime = 100 -- determines how soon git gutter will update after stopping typing, also swap file but we've disabled that anyway
opt.scrolloff = 4
opt.sidescrolloff = 8

-- mappings --
require("core.mappings")
require("core.autocmds")

-- clipboad fix --

local in_wsl = os.getenv('WSL_DISTRO_NAME') ~= nil
if in_wsl then
  g.clipboard = {
    name = 'wsl clipboard',
    copy =   { ["+"] = { "clip.exe" }, ["*"] = { "clip.exe" } },
    paste =  { ["+"] = { "neovim_paste" }, ["*"] = { "neovim_paste" } },
    cache_enabled = true
  }
end

-- plugins --

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
require("lazy").setup("plugins", { root = vim.fn.stdpath("data") .. "/lazy" })

-- post-plugin config --

vim.cmd.filetype("plugin indent on")
vim.cmd.syntax("on")
vim.diagnostic.config(
  {
    virtual_text = false,
    signs = true,
    underline = true,
    severity_sort = true
  }
)
-- g.ruby_host_prog = 'rvm default do neovim-ruby-host' -- ruby interpreter
