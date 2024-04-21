filetype on
syntax on
set nonumber
set nocompatible
"set relativenumber
set wildmenu
set wildmode=longest:list,full
set showmode
set showcmd
set hidden
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
set encoding=utf-8
set hlsearch
set incsearch
set clipboard=unnamedplus
"set mouse=a
set nowrap
set sw=4
set tabstop=4
set expandtab " convert tabs to spaces
"set path+=** " subfolders search
"set wildmenu " tabcompletions
"nmap <F1> :split<Return>
"nmap <F2> :vsplit<Return>
set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]
"              | | | | |  |   |      |  |     |    |
"              | | | | |  |   |      |  |     |    +-- current column
"              | | | | |  |   |      |  |     +-- current line
"              | | | | |  |   |      |  +-- current % into file
"              | | | | |  |   |      +-- current syntax
"              | | | | |  |   +-- current fileformat
"              | | | | |  +-- number of lines
"              | | | | +-- preview flag in square brackets
"              | | | +-- help flag in square brackets
"              | | +-- readonly flag in square brackets
"              | +-- rodified flag in square brackets
"              +-- full path to file in the buffer
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nmap ; :
set viminfo+=n~/.cache/.viminfo
