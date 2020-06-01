autocmd VimEnter * silent exec "! echo -ne '\e[1 q'"
autocmd VimLeave * silent exec "! echo -ne '\e[5 q'" 
" Don't try to be vi compatible
set nocompatible

" Helps force plugins to load correctly when it is turned back on below
filetype off

" TODO: Load plugins here (pathogen or vundle)

" Turn on syntax highlighting
syntax on

" For plugins to load correctly
filetype plugin indent on

" TODO: Pick a leader key
" let mapleader = ","

" Security
set modelines=0

" Show line numbers
set number

" Show file stats
set ruler

" Blink cursor on error instead of beeping (grr)
set visualbell

" Encoding
set encoding=utf-8

" Whitespace
set wrap
set textwidth=79
set formatoptions=cqrn1
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noshiftround

" Cursor motion
set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs
runtime! macros/matchit.vim

" Move up/down editor lines
nnoremap j gj
nnoremap k gk

" shebang bash
let @b='ggO#!/bin/bash'



" Allow hidden buffers
set hidden

" Rendering
set ttyfast

" Status bar
set laststatus=2

" Last line
set showmode
set showcmd

" Searching
" nnoremap / /\v
" vnoremap / /\v
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
map <leader><space> :let @/=''<cr> " clear search

" Remap help key.
inoremap <F1> <ESC>:set invfullscreen<CR>a
nnoremap <F1> :set invfullscreen<CR>
vnoremap <F1> :set invfullscreen<CR>

" Uncomment the following to have Vim jump to the last position when
" " reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe  "normal! g'\"" | endif
endif

" Textmate holdouts

" Formatting
map <leader>q gqip

" Visualize tabs and newlines
set listchars=tab:?\ ,eol:?
" Uncomment this to enable by default:
" set list " To enable by default
" Or use your leader key + l to toggle on/off
map <leader>l :set list!<CR> " Toggle tabs and EOL

set number relativenumber
set nu rnu
nnoremap S :%s//g<left><left>
vnoremap S :s//g<left><left>
vnoremap . :normal .<CR> 

" Color scheme (terminal)
set t_Co=256
set background=dark
let g:solarized_termcolors=256
let g:solarized_termtrans=1
" put https://raw.github.com/altercation/vim-colors-solarized/master/colors/solarized.vim
" in ~/.vim/colors/ and uncomment:
" colorscheme solarized
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
        endif
"TERM_FANCY_CURSOR  = 'true'
set guicursor=n-v-c-sm:block,i-ci-ve:ver25-Cursor,r-cr-o:hor20
call plug#begin()
Plug 'liuchengxu/space-vim-dark'
Plug 'Yggdroot/indentLine'    
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-sensible' 
Plug 'maxbrunsfeld/vim-emacs-bindings'
Plug 'tmsvg/pear-tree'
Plug 'vim-scripts/AutoComplPop'
call plug#end()

"if empty(glob("~/.vim/plugins"))
"    PlugInstall
"endif

colorscheme space-vim-dark
hi Comment guifg=#5C6370 ctermfg=59
hi Normal     ctermbg=NONE guibg=NONE
hi LineNr     ctermbg=NONE guibg=NONE
hi SignColumn ctermbg=NONE guibg=NONE
set guioptions+=a
set clipboard=unnamedplus
set complete+=kspell
set completeopt=menuone,longest
set shortmess+=c
"set guioptions?
set mouse=nicr
set mouse=a
set pastetoggle=<F3>
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!
let g:powerline_pycmd="py3"

inoremap <c-Left> <C-\><C-O>b
inoremap <c-Right> <C-\><C-O>w

inoremap <C-H> <C-\><C-O>h 
inoremap <C-L> <C-\><C-O>w
inoremap <C-J> <C-\><C-O>j
inoremap <C-K> <C-\><C-O>k
