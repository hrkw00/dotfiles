call plug#begin('~/.vim/plugged')
Plug 'mattn/vim-starwars'
Plug 'Shougo/denite.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'

Plug 'sheerun/vim-polyglot'

Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
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

set laststatus=2

filetype plugin on

syntax on

"----------------------------------------------------
" filetype
"----------------------------------------------------

augroup filetype
  autocmd!
  autocmd BufRead,BufNewFile *.ts setfiletype=typescript
  autocmd BufRead,BufNewFile *.tsx setfiletype=typescript
  autocmd BufRead,BufNewFile *.js setfiletype=javascript
augroup END


"----------------------------------------------------
" .vimrc.local
"----------------------------------------------------
"
augroup vimrc-local
  autocmd!
  autocmd BufNewFile,BufReadPost * call s:vimrc_local(expand('<afile>:p:h'))
augroup END

function! s:vimrc_local(loc)
  let files = findfile('.vimrc.local', escape(a:loc, ' ') . ';', -1)
  for i in reverse(filter(files, 'filereadable(v:val)'))
    source `=i`
  endfor
endfunction

"----------------------------------------------------
" denite
"----------------------------------------------------

nnoremap <silent> <C-p> :Denite file/rec<CR>

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

let s:ignore_globs = ['.git', '.svn', 'node_modules', 'public']

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
" vim-lsp
"----------------------------------------------------

let g:lsp_diagnostics_echo_cursor = 1

nnoremap <silent> gh :LspHover<CR>
nnoremap <silent> <C-g> :LspDefinition<CR>

if executable('typescript-language-server')
    au User lsp_setup call lsp#register_server({
      \ 'name': 'typescript support using typescript-language-server',
      \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
      \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
      \ 'whitelist': ['typescript', 'typescript.tsx', 'typescriptreact'],
      \ })
endif

if executable('flow')
  au User lsp_setup call lsp#register_server({
      \ 'name': 'flow',
      \ 'cmd': {server_info->['flow', 'lsp']},
      \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), '.flowconfig'))},
      \ 'whitelist': ['javascript', 'javascript.jsx'],
      \ })
endif


"----------------------------------------------------
" other keybinds
"----------------------------------------------------

autocmd QuickFixCmdPost *grep* cwindow

"autocmd CursorHold,CursorHoldI * update

autocmd BufWritePre * %s/\s\+$//e

