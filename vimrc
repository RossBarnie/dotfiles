if !has('nvim')
  set nocompatible
endif

call plug#begin('~/.vim/bundle')

Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'mileszs/ack.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'thoughtbot/vim-rspec', { 'for': 'ruby' }
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'kchmck/vim-coffee-script'
Plug 'tpope/vim-obsession'
if has('nvim')
  Plug 'benekastah/neomake'
endif
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'tpope/vim-endwise'
Plug 'danro/rename.vim'
Plug 'tpope/vim-haml'
Plug 'airblade/vim-gitgutter'
Plug 'elixir-lang/vim-elixir', { 'for': 'elixir' }

call plug#end()

filetype plugin indent on

if !has('nvim')
  set ttyfast " indicates fast terminal connection
endif
set lazyredraw " screen not redrawn while executing macros
set list " show invisibles
set listchars=eol:¬ " custom eol character
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
set colorcolumn=80
set autoread " automatically read files changed on disk
set re=1 " use old regex engine, should help with ruby files being slow
set cursorline! " highlight the current line of the cursor
set termguicolors
set timeoutlen=1000 ttimeoutlen=0
set showcmd
set noswapfile " no swap
set background=dark
colorscheme flatland
set noshowmode " don't show the mode as Airline is doing it
set splitbelow
set splitright

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
let g:ctrlp_switch_buffer = 0
nnoremap <leader>d :CtrlPTag<CR>

" NERDTree
" Toggle nerdtree with C-n
noremap <C-n> :NERDTreeTabsToggle<CR>
" current file in tree
noremap <F9> :NERDTreeFind<CR>

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'bubblegum'
let g:airline#extensions#branch#format = 1 " feature/foo becomes foo
let g:airline#extensions#ctrlp#show_adjacent_modes = 0
function! AirlineInit()
  let g:airline_section_a = airline#section#create_left(['mode', 'crypt', 'paste', 'spell', 'iminsert', 'branch'])
  let g:airline_section_b = airline#section#create(['hunks'])
  let g:airline_section_y = ''
endfunction
autocmd User AirlineAfterInit call AirlineInit()

" set leader
let mapleader=","

" Toggle paste mode
noremap <leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>

" clear trailing whitespace
nnoremap <silent> <Leader>w mm:%s/\s\+$//g<CR>:noh<CR>`m

" indent whole file
noremap <Leader>i mmgg=G`m<CR>

" edit vimrc
nnoremap <Leader>ev :vsp ~/.vimrc<CR>
" reload vimrc
nnoremap <Leader>rv :so ~/.vimrc<CR>:echom 'vimrc reloaded'<CR>

" turn off search highlight
nnoremap <leader>h :noh<CR>

" shortcut for project-wide search
nnoremap <leader>f :Ack!<SPACE>""<LEFT>

" automatically rebalance windows on vim resize

autocmd vimrc VimResized * :wincmd =

" Fugitive mappings
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gd :Gvdiff<CR>

" bind UP to :<UP>
nnoremap <UP> :<UP>

" Neomake stuff (Syntastic replacement)
autocmd vimrc BufWritePost * Neomake

autocmd vimrc FileType markdown set spell tw=80

" autocomplete
" Built-in, just use C-n

let vim_markdown_preview_hotkey='<C-m>'
let vim_markdown_preview_browser='Google Chrome'
let vim_markdown_preview_github=1

" Git gutter
let gitgutter_sign_column_always = 1

" Syntax Highlighting help
" Show syntax highlighting groups for word under cursor
nnoremap <leader>ss :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

command! MakeTags !ctags -R .
nnoremap <leader>mt :MakeTags<CR>
