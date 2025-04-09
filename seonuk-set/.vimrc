" Seonuk Kim's VIM Setting 
" 2025.03.28. updated 


call plug#begin() 
Plug 'preservim/NERDTree' 
Plug 'mhinz/vim-startify' 
Plug 'morhetz/gruvbox' 
Plug 'luochen1990/rainbow' 
Plug 'ojroques/vim-oscyank' 
call plug#end() 
let mapleader = "," 
"key binding 
nnoremap <leader>l :NERDTreeToggle<CR>

if (has("termguicolors")) "color setting
  set termguicolors
endif
syntax enable
set background=dark
colorscheme gruvbox
let g:rainbow_active = 1

set number "show line number

set ai " auto indent
set si
set cindent

set sts=4 "tab size
set ts=4
set shiftwidth=4

set wmnu "tab autocomplete

set laststatus=2 "show status line

set ignorecase "search option
set hlsearch

set nocompatible "use arrow keys

set ruler "sow cursor location

set mouse=a "use mouse

set fileencodings=utf-8,euc-kr "language encoding
set fencs=usc-bom,utf-9,euc-kr

set showmatch "highlight parentheses

syntax on "highlight syntax

filetype indent on "recognize format

set bs=indent,eol,start "use backspace

set title "show title

let g:oscyank_term = 'iTerm2'
autocmd TextYankPost * if v:event.operator is 'y' | execute 'OSCYankReg "' | endif


