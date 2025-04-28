local k = vim.keymap
local g = vim.g

g.mapleader = ","
g.maplocalleader = " "


-- general

k.set({'n', 'v'}, ';', ':')

 -- remove trailing whitespace
k.set('n', '<Leader>w', 'mm:%s/\\s\\+$//g<CR>:noh<CR>`m', { silent = true })

-- indent whole file
k.set('n', '<Leader>i', 'mmgg=G`m<CR>')

-- edit init.vim config (less useful since the modularisation, what should this do instead?
-- k.set('n', '<Leader>ev', ':tabe ~/.config/nvim/init.lua<CR>')
-- reload init.lua
k.set('n', '<Leader>rv', ':so ~/.config/nvim/init.lua<CR>:echom \'init.lua reloaded\'<CR>')

-- remove highlights
k.set('n', '<Leader>h', ':noh<CR>')

k.set('n', '<UP>', ':<UP>')

-- manage diffs
k.set('n', '<Leader>dt', ':diffthis<CR>')
k.set('n', '<Leader>do', ':diffoff!<CR>')

-- manage locallist
k.set('n', '<Leader>lo', ':lopen<CR>')
k.set('n', ']l', ':lnext<CR>')
k.set('n', '[l', ':lprev<CR>')
k.set('n', '<Leader>lq', ':lclose<CR>')
