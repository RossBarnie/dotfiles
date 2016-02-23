set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'rking/ag.vim'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'thoughtbot/vim-rspec'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'kchmck/vim-coffee-script'
Plugin 'tpope/vim-obsession'
Plugin 'christoomey/vim-tmux-runner'
Plugin 'benekastah/neomake'
Plugin 'fatih/vim-go'
Plugin 'JamshedVesuna/vim-markdown-preview'
Plugin 'tpope/vim-endwise'
Plugin 'danro/rename.vim'
Plugin 'tpope/vim-haml'

call vundle#end()

filetype plugin indent on

set ttyfast " indicates fast terminal connection
set lazyredraw " screen not redrawn while executing macros
set list " show invisibles
set listchars=eol:¬ " custom eol character
set number " show line numbers
set ruler " show line and column number
" set printoptions=number:y " shows line numbers in 'printed'? output
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

" use semi-colon to activate commands
nnoremap ; :
vnoremap ; :

" ignore certain files when using fuzzy search
let g:fuzzy_ignore = "*.png;*.PNG;*.JPG;*.jpg;*.GIF;*.gif;vendor/**;coverage/**;tmp/**;rdoc/**;*.sql"

" Only one way to learn...
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

set noswapfile " no swap

if executable('ag')
  " highlight ag searches
  let g:ag_highlight = 1
  " Ag.vim always starts searching from project root, not cwd
  let g:ag_working_path_mode="r"

  " use ag in CtrlP for listing files
  let g:ctrlp_user_command = 'ag -p ~/.agignore %s -l --nocolor --nogroup --hidden -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif
let g:ctrlp_switch_buffer = 0

set background=dark

" NERDTree
" Toggle nerdtree with C-n
noremap <C-n> :NERDTreeTabsToggle<CR>
" current file in tree
noremap <<F9> :NERDTreeFind<CR>
set timeoutlen=1000 ttimeoutlen=0
set showcmd

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_theme = 'molokai'

colorscheme Benokai

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
nnoremap <Leader>ev :vsp $MYVIMRC<CR>
" reload vimrc
nnoremap <Leader>rv :so $MYVIMRC<CR>:echom 'vimrc reloaded'<CR>

" edit tmux.conf
nnoremap <Leader>et :vsp ~/.tmux.conf<CR>

" turn off search highlight
nnoremap <leader>h :noh<CR>

" shortcut for project-wide search
nnoremap <leader>f :Ag<SPACE>

" automatically rebalance windows on vim resize
augroup auto_resize
  autocmd VimResized * :wincmd =
augroup END

" bindings for vim-rspec
let g:rspec_command="VtrSendCommand! bundle exec rspec {spec}"
let g:rspec_runner="os_x_iterm"
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

" Vim Tmux Runner commands
let g:VtrOrientation = "v"
let g:VtrPercentage = 35
nnoremap <leader>irb :VtrOpenRunner {'cmd': 'irb'}<CR>
nnoremap <leader>ar :VtrAttachToPane<CR>
nnoremap <leader>cr :VtrClearRunner<CR>
nnoremap <leader>or :VtrOpenRunner<CR>
nnoremap <leader>kr :VtrKillRunner<CR>
nnoremap <leader>r :VtrSendLinesToRunner<CR>
nnoremap <leader>sr :VtrSendCommandToRunner<CR>
nnoremap <leader>z :VtrFocusRunner<CR>

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
