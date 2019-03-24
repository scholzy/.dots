" init.vim
" Author: Michael Scholz
" Email: m@scholz.moe
"

" vim-plug {{{
if empty(glob('~/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
	\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif
" }}}
call plug#begin('~/.config/nvim/plugged')
" Things that need to be done first
" Leader key {{{
let mapleader = " "
nnoremap <SPACE> <Nop>
let maplocalleader = ","
" }}}

" General settings
" Backup handling {{{
set backup
set swapfile
set undofile

set undodir=~/.config/nvim/tmp/undo//     " undo files
set backupdir=~/.config/nvim/tmp/backup// " backups
set directory=~/.config/nvim/tmp/swap//   " swap files

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif
" }}}
" Commenting {{{
Plug 'tpope/vim-commentary'
" }}}
" Directional keybindings {{{
" Move by visual line, not textual line
noremap j gj
noremap k gk
noremap gj j
noremap gk k
" }}}
" Folding {{{
set foldmethod=marker
" Automagically navigate and open/close folds while moving
nnoremap <silent> z] :<C-u>silent! normal! zc<CR>zjzozz
nnoremap <silent> z[ :<C-u>silent! normal! zc<CR>zkzo[zzz
" }}}
" Fuzzy finding {{{
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all --no-update-rc'}
Plug 'junegunn/fzf.vim'
nmap <Leader>b :Buffers<CR>
nmap <Leader>t :Files<CR>
" }}}
" Git {{{
Plug 'tpope/vim-fugitive'
" }}}
" Indenting {{{
" Allow indenting by block in visual mode
vnoremap < <gv
vnoremap > >gv|
" }}}
" Line length {{{
nnoremap <silent> <leader>c :let &cc = &cc == '' ? '80' : ''<CR>
" }}}
" Searching {{{
" Use sane regexes.
nnoremap / /\v
vnoremap / /\v

nnoremap <leader>n :noh<CR>

set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
set gdefault
" }}}
" Spaces, not tabs {{{
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
" }}}

" Colors and UI
" Colorscheme {{{
Plug 'jeffkreeftmeijer/vim-dim'
set background=dark
" }}}
" Statusline {{{
Plug 'itchyny/lightline.vim'
set laststatus=2 " Make sure the statusline is turned on
set noshowmode " No need to show --INSERT-- anymore
let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'component_function': {
    \   'readonly': 'LightlineReadonly',
    \   'fugitive': 'LightlineFugitive'}
    \ }
let g:lightline.subseparator = { 'left': '', 'right': '' }
function! LightlineReadonly()
    return &readonly ? '' : ''
endfunction
function! LightlineFugitive()
    if exists('*fugitive#head')
        let branch = fugitive#head()
        return branch !=# '' ? ' '.branch : ''
    endif
    return ''
endfunction
" }}}

call plug#end()

colo dim
