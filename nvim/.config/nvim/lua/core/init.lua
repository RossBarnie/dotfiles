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
opt.lazyredraw = true                        -- screen not redrawn while executing macros
opt.list = false                             -- hide invisibles
opt.number = true                            -- show line numbers
opt.laststatus = 3                           -- always show status line
opt.title = true                             -- change title of terminal (if supported)
opt.hlsearch = true                          -- highlight search results
opt.showtabline = 0                          -- never show tabline (handled by Lualine)
opt.expandtab = true                         -- use spaces not tabs
opt.tabstop = 2                              -- 2 spaces for tab indenting
opt.softtabstop = 2                          -- 2 spaces for space indenting
opt.shiftwidth = 2                           -- use 2 spaces in autoindenting
opt.wrap = false                             -- don't wrap long lines
opt.backspace = { "indent", "eol", "start" } -- backspace can navigate over EOL and indents
opt.autoindent = true                        -- copy indent from previous line when starting a new one
opt.copyindent = true                        -- copy indent format (eg tabs, spaces) when starting a new line
opt.smartcase = true                         -- use smartcase when searching
opt.incsearch = true                         -- use incremental searching (show results as you type)
opt.history = 500
opt.undolevels = 500
opt.visualbell = true                            -- use a visual bell, not a beep, on error
opt.backup = false                               -- don't keep backups of current file
opt.wildmenu = true                              -- enhanced tab completion for new files
opt.colorcolumn = "135"                          -- show a block of colour at column 135 to indicate a line being too long
opt.autoread = true                              -- automatically read files changed on disk
opt.cursorline = true                            -- highlight the current line of the cursor
opt.termguicolors = true                         -- use 24-bit colours
opt.timeoutlen = 1000                            -- wait a second for key mappings to be completed
opt.ttimeoutlen = 0                              -- terminal escape sequence timeout
opt.showcmd = true                               -- show the command being run in the status line
opt.swapfile = false                             -- no swap
opt.background = "dark"
opt.showmode = false                             -- don't show the mode as Airline is doing it
opt.splitbelow = true                            -- hsplit creates split below current
opt.splitright = true                            -- vsplit creates split to the right of current
opt.shiftround = true                            -- round indent to multiple of shiftwidth
opt.spell = false                                -- disable spell check by default
opt.mouse = "a"                                  -- enable mouse use, I like it for switching contexts (browser to terminal)
opt.signcolumn = "yes"                           -- add signcolumn for git gutter and LSP
opt.updatetime = 100                             -- determines how soon git gutter and swap file will update after stopping typing
opt.scrolloff = 4                                -- minimum number of lines to keep above and below cursor on scroll
opt.sidescrolloff = 8                            -- minimum number of screen columns to keep to the left and right of the cursor
opt.undofile = true                              -- enable persistent undo
opt.undodir = vim.fn.stdpath("state") .. "/undo" -- set persistent undo directory
opt.diffopt:append("linematch:60")               -- align and mark changes between most similar lines, max 60

-- mappings --
require("core.mappings")
require("core.autocmds")

-- clipboad fix --

local in_wsl = os.getenv('WSL_DISTRO_NAME') ~= nil
if in_wsl then
  g.clipboard = {
    name = 'wsl clipboard',
    copy = { ["+"] = { "clip.exe" }, ["*"] = { "clip.exe" } },
    paste = { ["+"] = { "neovim_paste" }, ["*"] = { "neovim_paste" } },
    cache_enabled = true
  }
end

-- global diagnostic settings --

vim.diagnostic.config({
  jump = { float = true }
})

require('vim._core.ui2').enable()
vim.opt.completeopt:append("menuone")
vim.opt.completeopt:append("popup")
vim.opt.completeopt:append("noselect")
vim.opt.complete = ".^3,w,b,u,t"
vim.opt.winborder = "rounded"
vim.o.autocomplete = true
vim.o.iskeyword = "@,48-57,_,192-255,-"

