"Plugins
call plug#begin('~/AppData/Local/nvim/plugged')
	" Theme + Layout 
    Plug 'joshdick/onedark.vim'
    Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
    Plug 'tribela/vim-transparent'
	" Git
	Plug 'tpope/vim-fugitive'
	" File Nav
    Plug 'nvim-telescope/telescope.nvim'
	Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'
	" Editing/Formatting
	Plug 'godlygeek/tabular'
	Plug 'jonpas/vim-sqf-syntax'
    Plug 'tpope/vim-surround'
    " DevIcons
    Plug 'ryanoasis/vim-devicons'
    " TODO Highlighting
    Plug 'nvim-lua/plenary.nvim'
    Plug 'folke/todo-comments.nvim'
    " Templates
    Plug 'aperezdc/vim-template'
call plug#end()

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
highlight Normal guibg=none
"colorscheme gruvbox

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
" Fzf File search
let $PATH = "C:\\Program Files\\Git\\usr\\bin;" . $PATH
nnoremap <silent> <C-f> :Files<CR>
nnoremap <silent> <Leader>f :Rg<CR>
" Window Navigation with Ctrl-[hjkl]
noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
noremap <C-H> <C-W>h
noremap <C-L> <C-W>l
" tabsman
map <leader>tn :tabnew<cr>
map <leader>tl :tabnext<cr>
map <leader>th :tabprevious<cr>
map <leader>tm :tabmove
map <leader>tc :tabclose<cr>
map <leader>to :tabonly<cr>
" Explorer
nnoremap <leader>h :Ex<CR>
" delete without yanking
nnoremap <leader>d "_d
vnoremap <leader>d "_d
" paste no yank
vnoremap <leader>p "_dP
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
