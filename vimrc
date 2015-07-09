set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'bling/vim-airline'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'rking/ag.vim'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'thoughtbot/vim-rspec'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'tpope/vim-surround'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin 'kchmck/vim-coffee-script'
Plugin 'tpope/vim-obsession'
Plugin 'christoomey/vim-tmux-runner'
Plugin 'scrooloose/syntastic'

call vundle#end()

filetype plugin indent on

set nocompatible " use vim bindings
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

" use semi-colon to activate commands
nnoremap ; :
vnoremap ; :

" ignore certain files when using fuzzy search
let g:fuzzy_ignore = "*.png;*.PNG;*.JPG;*.jpg;*.GIF;*.gif;vendor/**;coverage/**;tmp/**;rdoc/**;assets/**"

" Only one way to learn...
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" easier split navigation
" nnoremap <C-J> <C-W><C-J>
" nnoremap <C-K> <C-W><C-K>
" nnoremap <C-L> <C-W><C-L>
" nnoremap <C-H> <C-W><C-H>

set noswapfile " no swap

if executable('ag')
  " highlight ag searches
  let g:ag_highlight = 1

  " use ag in CtrlP for listing files
  let g:ctrlp_user_command = 'ag %s -l --nocolor --nogroup --hidden
                              \ --ignore .git
                              \ --ignore .svn
                              \ --ignore .DS_Store
                              \ --ignore assets/images/
                              \ --ignore assets/fonts/
                              \ --ignore assets/javascripts/admin/vendor/
                              \ --ignore tmp/
                              \ --ignore bin/
                              \ -g ""'

  " ag is fast enough that CtrlP doens't need to cache
  let g:ctrlp_use_caching = 0
endif
let g:ctrlp_switch_buffer = 0

set background=dark

" NERDTree
" Toggle nerdtree with C-n
map <C-n> :NERDTreeTabsToggle<CR>
" current file in tree
map <<F9> :NERDTreeFind<CR>
set timeoutlen=1000 ttimeoutlen=0
set showcmd

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_theme = 'durant'

colorscheme Benokai

" Vim splits
set splitbelow
set splitright

" set leader
let mapleader=","

" Toggle paste mode
map <leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>

" clear trailing whitespace
nmap <silent> <Leader>w mm:%s/\s\+$//g<CR>:noh<CR>`m

" indent whole file
map <Leader>i mmgg=G`m<CR>

" edit vimrc
nmap <Leader>ev :vsp $MYVIMRC<CR>
" reload vimrc
nmap <Leader>r :so $MYVIMRC<CR>:echo 'vimrc reloaded'<CR>

" edit tmux.conf
nmap <Leader>et :vsp ~/.tmux.conf<CR>

" turn off search highlight
nmap <leader>h :noh<CR>

" shortcut for project-wide search
nmap <leader>f :Ag<SPACE>

" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" bindings for vim-rspec
let g:rspec_command="VtrSendCommand! bundle exec rspec {spec}"
let g:rspec_runner="os_x_iterm"
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

" Vim Tmux Runner commands
nnoremap <leader>irb :VtrOpenRunner {'orientation': 'h', 'percentage': 50, 'cmd': 'irb'}<CR>
nnoremap <leader>clr :VtrClearRunner<CR>
nnoremap <leader>or :VtrOpenRunner<CR>
nnoremap <leader>kr :VtrKillRunner<CR>

" Fugitive mappings
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gd :Gdiff<CR>

" bind UP to :<UP>
nnoremap <UP> :<UP>

set noshowmode

" Syntastic-related stuff
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" autocomplete
imap <tab> <C-P>

" some hack to get a nice cursor on insert mode (only works under tmux)
" let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
" let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
