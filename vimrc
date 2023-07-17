if !has('nvim') " nvim is always nocompatible
  set nocompatible
endif

call plug#begin('~/.vim/bundle')

Plug 'ctrlpvim/ctrlp.vim' " fuzzy file selector
Plug 'scrooloose/nerdtree' " file tree
Plug 'vim-airline/vim-airline' " status line replacement
Plug 'vim-airline/vim-airline-themes' " Themes for airline
Plug 'mileszs/ack.vim' " Project search
Plug 'ntpeters/vim-better-whitespace' " highlight trailing whitespace
Plug 'tpope/vim-surround' " Add 'surround' commands, eg cs'
Plug 'tpope/vim-fugitive' " Git in vim
Plug 'tpope/vim-obsession' " sessions in vim
if has('nvim')
  Plug 'neovim/nvim-lspconfig' " language server protocol support
  Plug 'b0o/schemastore.nvim' " json/yaml schemas
endif
Plug 'JamshedVesuna/vim-markdown-preview' " preview markdown files
Plug 'tpope/vim-endwise' " automatically add 'end' to ruby blocks
Plug 'airblade/vim-gitgutter' " git diff as signs in the sign column
Plug 'sjl/gundo.vim' " Undo on steroids
Plug 'w0ng/vim-hybrid' " hybrid colourscheme
Plug 'doums/darcula' " darcula colourscheme
Plug 'chr4/nginx.vim' " nginx file support
call plug#end()

filetype plugin indent on

if !has('nvim')
  set ttyfast " indicates fast terminal connection, not required for nvim
endif
set lazyredraw " screen not redrawn while executing macros
set list " show invisibles
set listchars=tab:>-,trail:-,nbsp:+,leadmultispace:· " show invisibles
set number " show line numbers
set laststatus=2 " always show status line
set title " change title of terminal (if supported)
set hlsearch " highlight search results
set showtabline=2 " always show tabs
syntax on
set expandtab " use spaces not tabs
set tabstop=2 " 2 spaces for tab indenting
set softtabstop=2 " 2 spaces for space indenting
set shiftwidth=2 " use 2 spaces in autoindenting
set nowrap " don't wrap long lines
set backspace=indent,eol,start " backspace can navigate over EOL and indents
set autoindent " copy indent from previous line when starting a new one
set copyindent " copy indent format (eg tabs, spaces) when starting a new line
set smartcase " use smartcase when searching
set incsearch " use incremental searching (show results as you type)
set history=500
set undolevels=500
set visualbell " use a visual bell, not a beep, on error
set nobackup " don't keep backups of current file
set wildmenu " enhanced tab completion for new files
set colorcolumn=120
set autoread " automatically read files changed on disk
set re=1 " use old regex engine, should help with ruby files being slow
set cursorline! " highlight the current line of the cursor
set termguicolors
set timeoutlen=1000 ttimeoutlen=0
set showcmd
set noswapfile " no swap
set background=dark
colorscheme darcula
set noshowmode " don't show the mode as Airline is doing it
set splitbelow " hsplit creates split below current
set splitright " vsplit creates split to the right of current
set shiftround " round indent to multiple of shiftwidth
set nospell " disable spell check by default
set mouse=a " enable mouse use, I like it for switching contexts (browser to terminal)
set signcolumn=number " share "signs" (eg gitgutter) with the number column
set updatetime=100 " determines how soon git gutter will update after stopping typing, also swap file but we've disabled that anyway

" reset vimrc autocommands
augroup vimrc
  autocmd!
augroup END

" use semi-colon to activate commands
nnoremap ; :
vnoremap ; :

" ignore certain files when using fuzzy search
let g:fuzzy_ignore = "*.png;*.PNG;*.JPG;*.jpg;*.GIF;*.gif;vendor/**;coverage/**;tmp/**;rdoc/**;*.sql;_build/**"

" Only one way to learn...
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
  " highlight ag searches
   let g:ackhighlight = 1

  " use ag in CtrlP for listing files
  let g:ctrlp_user_command = 'ag -p ~/.agignore %s -l --nocolor --nogroup --hidden -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_switch_buffer = 0

" NERDTree
" Toggle nerdtree with C-n
noremap <C-n> :NERDTreeTabsToggle<CR>
" current file in tree
noremap <F9> :NERDTreeFind<CR>

" Airline
let g:airline_powerline_fonts = 0
let g:airline_symbols_ascii = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'bubblegum'
let g:airline#extensions#ctrlp#show_adjacent_modes = 0
function! AirlineInit()
  let g:airline_section_a = airline#section#create_left(['mode', 'crypt', 'paste', 'spell', 'iminsert'])
  let g:airline_section_b = airline#section#create(['hunks', 'branch'])
  let g:airline_section_y = ''
endfunction
autocmd User AirlineAfterInit call AirlineInit()

" set leader
let mapleader=","
let maplocalleader="\\"

" Find definition
nnoremap <leader>d :CtrlPTag<CR>

" Toggle paste mode
noremap <leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>

" clear trailing whitespace
nnoremap <silent> <Leader>w mm:%s/\s\+$//g<CR>:noh<CR>`m

" indent whole file
noremap <Leader>i mmgg=G`m<CR>

if has('nvim')
  " edit init.vim config
  nnoremap <Leader>ev :tabe ~/.config/nvim/init.vim<CR>
  " reload init.vim
  nnoremap <Leader>rv :so ~/.config/nvim/init.vim<CR>:echom 'init.vim reloaded'<CR>
endif

if !has('nvim')
  " edit vimrc
  nnoremap <Leader>ev :tabe ~/.vimrc<CR>
  " reload vimrc
  nnoremap <Leader>rv :so ~/.vimrc<CR>:echom 'vimrc reloaded'<CR>
endif

" turn off search highlight
nnoremap <leader>h :noh<CR>

" shortcut for project-wide search
nnoremap <leader>f :Ack!<SPACE>""<LEFT>

" automatically rebalance windows on vim resize
autocmd vimrc VimResized * :wincmd =

" Fugitive mappings
nnoremap <leader>gs :G status<CR>
nnoremap <leader>gc :G commit<CR>
nnoremap <leader>gb :G blame<CR>
nnoremap <leader>gd :G diff<CR>

" bind UP to :<UP>
nnoremap <UP> :<UP>

" Neomake stuff (Syntastic replacement)
autocmd vimrc BufWritePost * Neomake

autocmd vimrc FileType markdown setlocal wrap spell textwidth=0 nolist linebreak

" autocomplete
" Built-in, just use C-n/C-p

let vim_markdown_preview_hotkey='<C-m>'
let vim_markdown_preview_browser='firefox'
let vim_markdown_preview_github=1

" Syntax Highlighting help
" Show syntax highlighting groups for word under cursor
nnoremap <leader>ss :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

command! MakeTags !ctags -R --exclude="*.js" --exclude="*.sass" --exclude="*.css" --exclude=node_modules .
nnoremap <leader>mt :MakeTags<CR>

" Gundo
nnoremap <leader>u :GundoShow<CR>

" Commenting
autocmd vimrc FileType vim nnoremap <buffer> <localleader>c mmI"<SPACE><ESC>`m
autocmd vimrc FileType ruby,eruby,yaml nnoremap <buffer> <localleader>c mmI#<SPACE><ESC>`m

autocmd vimrc FileType ruby,eruby,yaml setlocal iskeyword+=?

" Ruby interpreter
if has('nvim')
  let g:ruby_host_prog = 'rvm default do neovim-ruby-host'

  " fix clipboard in WSL
  lua << EOF
  in_wsl = os.getenv('WSL_DISTRO_NAME') ~= nil
  if in_wsl then
    vim.g.clipboard = {
      name = 'wsl clipboard',
      copy =   { ["+"] = { "clip.exe" }, ["*"] = { "clip.exe" } },
      paste =  { ["+"] = { "neovim_paste" }, ["*"] = { "neovim_paste" } },
      cache_enabled = true
    }
  end

  -- Configure LSP as omnifunc

  -- Setup language servers.
  local lspconfig = require('lspconfig')
  lspconfig.solargraph.setup{}
  lspconfig.marksman.setup{}
  lspconfig.yamlls.setup{
    settings = {
      yaml = {
        schemaStore = {
          enable = false
        },
        schemas = require('schemastore').yaml.schemas(),
      },
    },
  }
  lspconfig.rust_analyzer.setup {
    -- Server-specific settings. See `:help lspconfig-setup`
    settings = {
      ['rust-analyzer'] = {},
    },
  }

  -- Global mappings.
  -- See `:help vim.diagnostic.*` for documentation on any of the below functions
  vim.keymap.set('n', '<space>e', vim.diagnostic.open_float) -- might want to change this to (local) leader
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
  vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

  -- Use LspAttach autocommand to only map the following keys
  -- after the language server attaches to the current buffer
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
      -- Enable completion triggered by <c-x><c-o>
      vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

      -- Buffer local mappings.
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      local opts = { buffer = ev.buf }
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
      vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
      vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
      vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, opts)
      vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
      vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
      vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
      vim.keymap.set('n', '<space>f', function()
        vim.lsp.buf.format { async = true }
      end, opts)
    end,
  })
EOF
endif
