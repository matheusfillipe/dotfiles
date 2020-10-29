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

" set number relativenumber
set number relativenumber

set nu rnu
nnoremap S :%s//g<left><left>
vnoremap s :s//g<left><left>
vnoremap . :normal .<cr> 

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
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'fidian/hexmode' 
Plug 'davidhalter/jedi-vim'
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'bkad/CamelCaseMotion'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'voldikss/vim-floaterm'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-repeat'
Plug 'stanangeloff/php.vim'
Plug 'lervag/vimtex'
Plug 'rust-lang/rust.vim'
Plug 'fatih/vim-go'
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
" Temporary workaround for: https://github.com/neovim/neovim/issues/1716
if has("nvim")
  command! W w !sudo -n tee % > /dev/null || echo "Press <leader>w to authenticate and try again"
  map <leader>w :new<cr>:term sudo true<cr>
else
  command W :execute ':silent w !sudo tee % > /dev/null' | :edit!
end

"let g:powerline_pycmd="py3"

inoremap <c-Left> <C-\><C-O>b
inoremap <c-Right> <C-\><C-O>w

inoremap <C-H> <C-\><C-O>h 
inoremap <C-L> <C-\><C-O>w
inoremap <C-J> <C-\><C-O>j
inoremap <C-K> <C-\><C-O>k
noremap  ZS :w
inoremap <C-Z> :w

" Spell Check
let g:myLang=0
function! ToggleSpell()
  let g:myLangList=["nospell","en_us","pt_br"]
  let g:myLang=g:myLang+1
  if g:myLang>=len(g:myLangList) | let g:myLang=0 | endif
  if g:myLang==0
    setlocal nospell
  else
    execute "setlocal spell spelllang=".get(g:myLangList, g:myLang)
  endif
  echo "spell checking language:" g:myLangList[g:myLang]
endfunction
nmap <silent> <F7> :call ToggleSpell()<CR>

nnoremap <C-a> :bn<CR>
nnoremap <C-S-a> :bp<CR>

inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

"map <silent> w <Plug>CamelCaseMotion_w
"map <silent> b <Plug>CamelCaseMotion_b
"map <silent> e <Plug>CamelCaseMotion_e
"map <silent> ge <Plug>CamelCaseMotion_ge
"sunmap w
"sunmap b
"sunmap e
"sunmap ge
"
let g:airline_powerline_fonts = 1
nnoremap <leader>s :set syntax=

let g:camelcasemotion_key = '<leader>'

nnoremap <A-f> :FloatermNew lf<CR>
nnoremap <A-d> :FloatermNew --wintype='normal' --position='bottom' --height=0.25 
vnoremap <A-s> :'<,'>FloatermSend<CR>
let g:floaterm_keymap_new    = '<A-t>'
let g:floaterm_keymap_prev   = '<A-p>'
let g:floaterm_keymap_next   = '<A-n>'
let g:floaterm_keymap_toggle = '<A-q>'

nnoremap <Tab> :bn<CR>
noremap ZW :bd<CR>

nnoremap <leader>pt :set dictionary+=/usr/share/dict/pt_BR.dic<CR>
nnoremap <leader>en :set dictionary+=/usr/share/dict/american-english <CR>
nnoremap <leader>c :set dictionary=<CR>

function! Spell_correct(n)
"  let n = nr2char(getchar())
  let n = a:n
  if a:n<=0
    let n=1
  endif
  execute ":normal [s".n."z=\<C-o>"
endfunction

imap <c-l> <c-g>u<Esc>[s1z=`]a<c-g>u
nmap <silent> <c-l> :<C-u>call Spell_correct(v:count)<cr>
"nnoremap <esc> :noh<return><esc>

vmap < <gv
vmap > >gv
let g:rustfmt_autosave = 1
let g:tex_flavor = 'latex'
set cedit=

nnoremap <C-S-l> vg_
nnoremap <C-S-h> v0
inoremap <C-BS> <Esc>vbc
inoremap <M-b> <Esc>bi
inoremap  <M-w> <Esc>wi
inoremap <C-S> <Esc>:w<CR>a
nnoremap <C-S> :w<CR>
inoremap <M-BS> <Esc>dba
inoremap <M-d> <Esc>dwi
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-k> <Up>
cnoremap <C-j> <Down>
cnoremap <M-BS> <C-w>


" Workarounds for vim-orgmode
autocmd FileType org nnoremap <C-Space> :OrgCheckBoxToggle<CR>
nnoremap <C-S-l> vg_
nnoremap <C-S-h> v0
inoremap <C-BS> <Esc>vbc
inoremap <M-b> <Esc>bi
inoremap <M-w> <Esc>wi
inoremap <C-S> <Esc>:w<CR>a
nnoremap <C-S> :w<CR>
inoremap <M-BS> <Esc>vbxa
inoremap <M-d> <Esc>vexi
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-k> <Up>
cnoremap <C-j> <Down>
cnoremap <M-BS> <C-w>
nnoremap <BS> :cd ..<cr>
nnoremap <M-BS> :cd -<cr>
nnoremap <C-Right> :vertical resize +5<CR>
nnoremap <C-Left>  :vertical resize -5<CR>
nnoremap <C-Up>   :resize +5<CR>
nnoremap <C-Down> :resize -5<CR>

autocmd FileType c,cpp,java,scala,go,rust,javascript let b:comment_leader = '//'
autocmd FileType sh,ruby,python,perl,org   let b:comment_leader = '#'
autocmd FileType conf,fstab       let b:comment_leader = '#'
autocmd FileType tex              let b:comment_leader = '%'
autocmd FileType mail             let b:comment_leader = '>'
autocmd FileType vim              let b:comment_leader = '"'
function! CommentToggle()
    execute ':silent! s/\([^ ]\)/' . escape(b:comment_leader,'\/') . ' \1/'
    execute ':silent! s/^\( *\)' . escape(b:comment_leader,'\/') . ' \?' . escape(b:comment_leader,'\/') . ' \?/\1/'
endfunction
nmap ; :call CommentToggle()<CR>

" Clipboard
nnoremap dil ^d$
nnoremap vil ^v$
nnoremap cil ^c$
nnoremap gp i<c-r>0<esc>k$Jx
nnoremap <c-p> a<c-r>0<esc>k$Jx
inoremap <c-p> <c-r>0<esc>k$Jxa

