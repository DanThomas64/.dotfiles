"Plugins
call plug#begin('~/AppData/Local/nvim/plugged')
	" Theme + Layout 
    Plug 'joshdick/onedark.vim'
    Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
    Plug 'tribela/vim-transparent'
    Plug 'dracula/vim', { 'as': 'dracula' }
    " Startify
    Plug 'mhinz/vim-startify'
	" Git
	Plug 'tpope/vim-fugitive'
	" File Nav
    Plug 'nvim-telescope/telescop.nvim'
	Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'
	Plug 'scrooloose/nerdtree'
	" Editing/Formatting
	Plug 'godlygeek/tabular'
	Plug 'jonpas/vim-sqf-syntax'
    Plug 'tpope/vim-surround'
    " DevIcons
    Plug 'ryanoasis/vim-devicons'
    " TODO Highlighting
    Plug 'nvim-lua/plenary.nvim'
    Plug 'folke/todo-comments.nvim'
    Plug 'aperezdc/vim-template'
call plug#end()

" Startify
let g:startify_custom_header = [
    \ '',
    \ '$$$$$$$\                  $$\ $$\      $$\           $$\  $$$$$$\   ',
    \ '$$  __$$\                 $$ |$$ | $\  $$ |          $$ |$$  __$$\  ',
    \ '$$ |  $$ | $$$$$$\   $$$$$$$ |$$ |$$$\ $$ | $$$$$$\  $$ |$$ /  \__| ',
    \ '$$$$$$$\ | \____$$\ $$  __$$ |$$ $$ $$\$$ |$$  __$$\ $$ |$$$$\      ',
    \ '$$  __$$\  $$$$$$$ |$$ /  $$ |$$$$  _$$$$ |$$ /  $$ |$$ |$$  _|     ',
    \ '$$ |  $$ |$$  __$$ |$$ |  $$ |$$$  / \$$$ |$$ |  $$ |$$ |$$ |       ',
    \ '$$$$$$$  |\$$$$$$$ |\$$$$$$$ |$$  /   \$$ |\$$$$$$  |$$ |$$ |       ',
    \ '\_______/  \_______| \_______|\__/     \__| \______/ \__|\__| ',
    \ ' ',
    \ 'Welcome back mother fucker.. :D ',
    \ ]

let g:startify_bookmarks =  [ 
    \{'v': 'D:\Projects\.dotfiles\.vim\nvim\init.vim'},
    \{'p': 'D:\Projects\.dotfiles\powershell\user_profile.ps1'},
    \]


" General Vim Settings
set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching 
set ignorecase              " case insensitive 
set mouse=v                 " middle-click paste with 
set nohlsearch                " highlight search 
set incsearch               " incremental search
set tabstop=4               " number of columns occupied by a tab 
set hidden                  " Any buff in background
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard
set cursorline              " highlight current cursorline
set ttyfast                 " Speed up scrolling in Vim
set nu rnu                  " Line Numbering
set noerrorbells
set nowrap
set noswapfile
set nobackup
set scrolloff=8
set signcolumn=yes
set colorcolumn=80
syntax on                   " syntax highlighting
filetype plugin on
filetype plugin indent on   " allow auto-indenting depending on file type

colorscheme onedark
"
" NerdTree Settings
"
" Start NERDTree. If a file is specified, move the cursor to its window.
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif
" Exit Vim if NERDTree is the only window remaining in the only tab.
" autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

lua << EOF
    require("todo-comments").setup {}
EOF

" Keymappings
" General
let mapleader = " "
inoremap jj <Esc>
" Clear Highlights
nnoremap <Leader><space> :noh<cr>
" No recommended but needed to stop me fatfingering
" Pause does not work in Terminal at this time.
nnoremap <c-z> :u<CR> 
" NerdTree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
" Fzf File search
let $PATH = "C:\\Program Files\\Git\\usr\\bin;" . $PATH
nnoremap <silent> <C-f> :Files<CR>
nnoremap <silent> <Leader>f :Rg<CR>
" Window Navigation with Ctrl-[hjkl]
noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
noremap <C-H> <C-W>h
noremap <C-L> <C-W>l
" Startify
nnoremap <leader>h :Startify<CR>
" tabsman
map <leader>tn :tabnew<cr>
map <leader>tl :tabnext
map <leader>th :tabnext
map <leader>tm :tabmove
map <leader>tc :tabclose<cr>
map <leader>to :tabonly<cr>

" split
noremap <leader>sv :vsplit<CR>
noremap <leader>sh :split<CR>

" Move text
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
" sqf write
autocmd Bufwritepre,filewritepre *.sqf execute "normal ma"
autocmd Bufwritepre,filewritepre *.sqf exe "1," . 10 . "g/Last Update:.*/s/Last Update:.*/Last Update: " .strftime("%c")
autocmd bufwritepost,filewritepost *.sqf execute "normal `a"
