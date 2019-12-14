call plug#begin('~/.vim/plugged')
Plug 'wincent/command-t'
Plug 'mxw/vim-jsx'
call plug#end()

set hidden

set number

set noswapfile

set title

set expandtab

set ignorecase

set smartcase

set autoread

set tabstop=2

set shiftwidth=2

set cursorline

set hlsearch

set incsearch 

set autoindent

set smartindent

set nocompatible

set wildmenu

set ruler

set clipboard+=unnamed

set backspace=indent,eol,start

set wildignore+=*/node_modules/*

set showmode

syntax on

"----------------------------------------------------
" command-t
"----------------------------------------------------
nnoremap <silent> <C-t> :CommandT<CR>

nnoremap <silent> <C-b> :CommandTBuffer<CR>

"----------------------------------------------------
" other keybinds
"----------------------------------------------------

autocmd QuickFixCmdPost *grep* cwindow

nnoremap zz <Esc>:update<cr>

