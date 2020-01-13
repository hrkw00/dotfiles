call plug#begin('~/.vim/plugged')
Plug 'wincent/command-t'
Plug 'mattn/vim-starwars'
Plug 'Shougo/denite.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
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

set wildignore+=*/node_modules/*

set backspace=indent,eol,start

set showmode

set modifiable

set write

syntax on

"----------------------------------------------------
" command-t
"----------------------------------------------------
"nnoremap <silent> <C-t> :CommandT<CR>

"nnoremap <silent> <C-b> :CommandTBuffer<CR>

"----------------------------------------------------
" denite 
"----------------------------------------------------
nnoremap <silent> <C-t> :Denite file/rec<CR>

autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space>
  \ denite#do_map('toggle_select').'j'
endfunction

let s:ignore_globs = ['.git', '.svn', 'node_modules']

call denite#custom#var('file/rec', 'command', [
      \ 'ag',
      \ '--follow',
      \ ] + map(deepcopy(s:ignore_globs), { k, v -> '--ignore=' . v }) + [
      \ '--nocolor',
      \ '--nogroup',
      \ '-g',
      \ ''
      \ ])

call denite#custom#source('file/rec', 'matchers', ['matcher/substring'])

call denite#custom#filter('matcher/ignore_globs', 'ignore_globs', s:ignore_globs)

call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'default_opts', ['--follow', '--no-group', '--no-color'])

command! Dgrep execute(":Denite grep -buffer-name=grep-buffer-denite")
command! Dresume execute(":Denite -resume -buffer-name=grep-buffer-denite")

"----------------------------------------------------
" other keybinds
"----------------------------------------------------

autocmd QuickFixCmdPost *grep* cwindow

autocmd CursorHold,CursorHoldI * update

