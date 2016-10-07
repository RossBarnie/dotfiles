set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'mileszs/ack.vim'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'thoughtbot/vim-rspec'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'kchmck/vim-coffee-script'
Plugin 'tpope/vim-obsession'
Plugin 'benekastah/neomake'
Plugin 'fatih/vim-go'
Plugin 'JamshedVesuna/vim-markdown-preview'
Plugin 'tpope/vim-endwise'
Plugin 'danro/rename.vim'
Plugin 'tpope/vim-haml'
Plugin 'airblade/vim-gitgutter'
Plugin 'elixir-lang/vim-elixir'

call vundle#end()

filetype plugin indent on

set ttyfast " indicates fast terminal connection
set lazyredraw " screen not redrawn while executing macros
set list " show invisibles
set listchars=eol:¬ " custom eol character
set number " show line numbers
set ruler " show line and column number
set laststatus=2 number title hlsearch " no idea
set showtabline=2 " always show tabs
syntax enable
set expandtab " use spaces not tabs
set tabstop=2 " 2 spaces for tab indenting
set softtabstop=2 " 2 spaces for space indenting
set shiftwidth=2 " use 2 spaces in autoindenting
set nowrap " don't wrap long lines
set backspace=indent,eol,start " backspace can navigate over EOL and indents
set autoindent " copy indent from previous line when starting a new one
set copyindent " copy indend format (eg tabs, spaces) when starting a new line
set smartcase " use smartcase when searching
set incsearch " use incremental searching (show results as you type)
set history=500
set undolevels=500
set title " set title to value of 'titlestring'
set visualbell " use a visual bell, not a beep, on error
set nobackup " don't keep backups of current file
set wildmenu " enhanced tab completion for new files
set colorcolumn=80
set autoread " automatically read files changed on disk
set re=1 " use old regex engine, should help with ruby files being slow
set cursorline! " highlight the current line of the cursor
set termguicolors

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

set noswapfile " no swap

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

let g:ctrlp_switch_buffer = 0

set background=dark

" NERDTree
" Toggle nerdtree with C-n
noremap <C-n> :NERDTreeTabsToggle<CR>
" current file in tree
noremap <<F9> :NERDTreeFind<CR>
set timeoutlen=1000 ttimeoutlen=0
set showcmd

colorscheme flatland

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'bubblegum'

" Vim splits
set splitbelow
set splitright

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
augroup auto_resize
  autocmd VimResized * :wincmd =
augroup END

" Fugitive mappings
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gd :Gdiff<CR>

" bind UP to :<UP>
nnoremap <UP> :<UP>

set noshowmode

" Neomake stuff (Syntastic replacement)
augroup auto_syntax_check
  autocmd! BufWritePost * Neomake
augroup END
let g:neomake_haml_haml_maker = {
    \ 'args': ['-c'],
    \ 'errorformat': 'Haml error on line %l: %m,' .
        \ 'Syntax error on line %l: %m,' .
        \ '%-G%.%#'
    \ }
let g:neomake_haml_enabled_makers = ['haml']

" autocomplete
inoremap <C-tab> <C-P>

let vim_markdown_preview_hotkey='<C-m>'
let vim_markdown_preview_github=1

" Git gutter
let gitgutter_sign_column_always = 1
