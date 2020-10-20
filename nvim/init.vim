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

function! s:IsFirenvimActive(event) abort
  if !exists('*nvim_get_chan_info')
    return 0
  endif
  let l:ui = nvim_get_chan_info(a:event.chan)
  return has_key(l:ui, 'client') && has_key(l:ui.client, 'name') &&
      \ l:ui.client.name =~? 'Firenvim'
endfunction

function! OnUIEnter(event) abort
  if s:IsFirenvimActive(a:event)
    set formatoptions= 
    nnoremap <space> :set lines=28 columns=110 <CR>
    nnoremap <leader-e> :setlocal spell spelllang=en_us <CR>
    nnoremap <leader-p> :setlocal spell spelllang=pt_br <CR>
endif
endfunction
autocmd UIEnter * call OnUIEnter(deepcopy(v:event))

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
nnoremap s :%s//g<left><left>
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
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'fidian/hexmode' 
" Plug 'davidhalter/jedi-vim'
" Plug 'deoplete-plugins/deoplete-jedi'
Plug 'bkad/CamelCaseMotion'
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'voldikss/vim-floaterm'
Plug 'reedes/vim-wordy'
Plug 'easymotion/vim-easymotion'
Plug 'rbgrouleff/bclose.vim'
Plug 'tpope/vim-repeat'
Plug 'stanangeloff/php.vim'
Plug 'preservim/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'preservim/nerdcommenter'
Plug 'dart-lang/dart-vim-plugin'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'rust-lang/rust.vim'
Plug 'preservim/tagbar'
Plug 'lervag/vimtex'
Plug 'qpkorr/vim-bufkill'
Plug 'chr4/nginx.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf.vim'
Plug 'jceb/vim-orgmode'
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
command! W :execute ':silent w !sudo tee % > /dev/null' | :edit!
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
imap <silent> <F7> <Esc>:call ToggleSpell()<CR>a

nnoremap <C-a> :bn<CR>
nnoremap <C-Tab> :bn<CR>
nnoremap <C-S-Tab> :bp<CR>

inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
let g:camelcasemotion_key = '<leader>'
" map <silent> w <Plug>CamelCaseMotion_w
" map <silent> b <Plug>CamelCaseMotion_b
" map <silent> e <Plug>CamelCaseMotion_e
" map <silent> ge <Plug>CamelCaseMotion_ge
" sunmap w
" sunmap b
" sunmap e
" sunmap ge
let g:airline_theme='luna'
let g:airline_powerline_fonts = 1
set  guifont=SauceCodePro\ Nerd\ Font:h14
set background=light
highlight Normal ctermbg=none
highlight NonText ctermbg=none


  let g:firenvim_config = { 
      \ 'globalSettings': {
          \ 'alt': 'all',
      \  },
      \ 'localSettings': {
          \ '.*': {
              \ 'cmdline': 'neovim',
              \ 'priority': 0,
              \ 'selector': 'textarea',
              \ 'takeover': 'never',
          \ },
      \ }
  \ }
  " let fc = g:firenvim_config['localSettings']
  " let fc['.*'] = { 'takeover': 'never', 'priority': 1 }

nnoremap <leader>s :set syntax=

nnoremap <A-f> :FloatermNew lf<CR>
nnoremap <A-S-h> :FloatermHide<CR>
tnoremap <A-S-h> <C-\><C-N>:FloatermHide<CR>
nnoremap <A-d> :FloatermNew --wintype='normal' --position='bottom' --height=0.25 
vnoremap <A-s> :'<,'>FloatermSend<CR>

let g:floaterm_keymap_new    = '<A-t>'
let g:floaterm_keymap_prev   = '<A-p>'
let g:floaterm_keymap_next   = '<A-n>'

tnoremap <C-M-h> <C-\><C-n><C-w>h
tnoremap <C-M-j> <C-\><C-n><C-w>j
tnoremap <C-M-k> <C-\><C-n><C-w>k
tnoremap <C-M-l> <C-\><C-n><C-w>l
tnoremap <C-M-n> <C-\><C-n>

nnoremap <C-M-h> <C-w>h
nnoremap <C-M-j> <C-w>j
nnoremap <C-M-k> <C-w>k
nnoremap <C-M-l> <C-w>l

"nnoremap <Tab> :bn<CR>
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
  execute ":normal [s".n."z="
endfunction

imap <c-l> <c-g>u<Esc>[s1z=`]a<c-g>u
nmap <silent> <c-l> :<C-u>call Spell_correct(v:count)<cr>
nnoremap <leader>q :Bclose<cr>

" let g:session_autosave_periodic = 1 
" let session_autosave = 'yes'
" nnoremap <leader>O :OpenSession 
" nnoremap <leader>S :SaveSession 
" nnoremap <leader>D :DeleteSession 
set sessionoptions=buffers,curdir,folds,help,tabpages,winsize
let g:session_dir="~/.vim/sessions/"

function! s:SaveSession(name)
  if (exists("g:last_saved_session"))
    execute "mks! ".g:session_dir.g:last_saved_session.".vim"
    echo "Saved Session ".g:last_saved_session
  else
    execute "!mkdir -p ".g:session_dir
    execute "mks! ".g:session_dir.a:name.".vim"
    exe "let g:last_saved_session=a:name"
    command! SaveSessionRepeat call s:SaveSession("")
    nnoremap <leader>S :SaveSessionRepeat<CR>
  endif
endfunction

function! s:LoadSession(name)
  execute "source ".g:session_dir.a:name.".vim"
  exe "let g:last_saved_session=a:name"
  command! SaveSessionRepeat call s:SaveSession("")
  nnoremap <leader>S :SaveSessionRepeat<CR>
endfunction

function! s:DeleteSession(name)
  execute "!rm "g:session_dir.a:name.".vim"
endfunction

function! s:Sessions(argl, cmdl, pos) abort
  let l=split(a:cmdl, " ")
  if len(l) > 1
    let x=l[-1]
  else
    let x=""
  endif
  return map(split(globpath('~/.vim/sessions/', x.'*.vim'), '\n'), {idx, val -> substitute(fnamemodify(val,':t'), ".vim", "", "g")})
endfunction

command! -nargs=1 -complete=customlist,s:Sessions SaveSession call s:SaveSession(<f-args>)
command! -nargs=1 -complete=customlist,s:Sessions LoadSession call s:LoadSession(<f-args>)
command! -nargs=1 -complete=customlist,s:Sessions DeleteSession call s:DeleteSession(<f-args>)

nnoremap <leader>S :SaveSession 
nnoremap <leader>O :LoadSession 
nnoremap <leader>D :DeleteSession 
set path=.,,**

nnoremap <A-\> :NERDTreeToggle<CR>
nmap tt :tabnew<CR>
nmap td :tab split<CR>
nmap tn :tabn<CR>
nmap <Tab> :tabn<CR>
nmap tp :tabp<CR>
nmap <S-Tab> :tabp<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeGitStatusWithFlags = 1
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
set encoding=utf8
set inccommand=split

vmap < <gv
vmap > >gv
let g:rustfmt_autosave = 1
let g:tex_flavor = 'latex'
let g:dart_format_on_save = 1
nnoremap <A-z> :TagbarToggle<CR><C-M-l>
nnoremap <A-c> :!ctags -R .<CR>
nnoremap <A-w> :tabnext <CR>
nnoremap <A-q> :tabprevious <CR>
nnoremap ZD :BD<CR>
nnoremap <A-1> 1gt
nnoremap <A-2> 2gt
nnoremap <A-3> 3gt
nnoremap <A-4> 4gt
nnoremap <A-5> 5gt
nnoremap <A-6> 6gt
nnoremap <A-7> 7gt
nnoremap <A-8> 8gt
nnoremap <A-9> 9gt

nnoremap <C-Space> :nnoremap <lt>Space> :! <lt>CR><left><left><left><left><left>
nmap <Esc> :noh<CR>
cnoremap <C-A> <Home>
cnoremap <C-L> <C-Right>
cnoremap <C-H> <C-Left>
cnoremap <C-f> q:
autocmd BufEnter * silent! lcd %:p:h
let g:tagbar_sort=0
set cedit=
nmap <silent> <leader>i :call CocActionAsync('doHover') <cr>
autocmd CursorHold * silent call CocActionAsync('highlight')
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>d <Plug>(coc-definition)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>r <Plug>(coc-rename)
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>qf  <Plug>(coc-fix-current)



" COC
"

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

inoremap <silent><expr> <c-space> coc#refresh()


"
" INSERT mode floating window scrolling {{{
function! s:coc_float_scroll(amount) abort
  let float = coc#util#get_float()
  if !float | return '' | endif
  let buf = nvim_win_get_buf(float)
  let buf_height = nvim_buf_line_count(buf)
  let win_height = nvim_win_get_height(float)
  if buf_height < win_height | return '' | endif
  let pos = nvim_win_get_cursor(float)
  try
    let last_amount = nvim_win_get_var(float, 'coc_float_scroll_last_amount')
  catch
    let last_amount = 0
  endtry
  if a:amount > 0
    if pos[0] == 1
      let pos[0] += a:amount + win_height - 2
    elseif last_amount > 0
      let pos[0] += a:amount
    else
      let pos[0] += a:amount + win_height - 3
    endif
    let pos[0] = pos[0] < buf_height ? pos[0] : buf_height
  elseif a:amount < 0
    if pos[0] == buf_height
      let pos[0] += a:amount - win_height + 2
    elseif last_amount < 0
      let pos[0] += a:amount
    else
      let pos[0] += a:amount - win_height + 3
    endif
    let pos[0] = pos[0] > 1 ? pos[0] : 1
  endif
  call nvim_win_set_var(float, 'coc_float_scroll_last_amount', a:amount)
  call nvim_win_set_cursor(float, pos)
  return ''
endfunction
let g:coc_snippet_next = '<c-l>'
let g:coc_snippet_prev = '<c-h>'
inoremap <silent><expr> <A-j> coc#util#has_float() ? <SID>coc_float_scroll(1) : "\<c-j>"
inoremap <silent><expr> <A-k> coc#util#has_float() ? <SID>coc_float_scroll(-1) : "\<c-k>"
vnoremap <silent><expr> <A-j> coc#util#has_float() ? <SID>coc_float_scroll(1) : "\<c-j>"
vnoremap <silent><expr> <A-k> coc#util#has_float() ? <SID>coc_float_scroll(-1) : "\<c-k>"

nnoremap <leader>E :CocDiagnostics<CR>

set formatoptions=cqrn1
nnoremap <leader>F :set formatoptions=cqrn1<CR>

" Flutter
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>ac  <Plug>(coc-codeaction)
let g:tagbar_type_dart = { 'ctagsbin': '~/.pub-cache/bin/dart_ctags' }

" Autocomplete
"
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <silent><expr> <c-space> coc#refresh()
nnoremap <M-C-R> :source $MYVIMRC<CR>

" Neovim-qt
if exists('g:GuiLoaded')
  set pumblend=5
endif
nnoremap <C-F> :Ag 

autocmd User CocOpenFloat call setwinvar(g:coc_last_float_win, "&winblend", 20)

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" FZF
"
nnoremap <A-g> :GFiles<CR>
nnoremap <A-f> :Files<CR>
autocmd VimEnter * nmap <A-b> :Buffers<CR>
nmap <A-h> :History
nmap <M-:> :Commands<CR>
let g:fzf_tags_command = "ctags -R"
let g:fzf_preview_window = 'right:60%'
let g:fzf_layout = { 'window': 'botright new' }
command! -bang -nargs=? -complete=dir Files
	\ call fzf#vim#files(<q-args>, {'options': ['--preview', 'BAT_THEME="Dracula" bat --color=always {}']}, <bang>0)
command! -bang -nargs=? -complete=dir GFiles
	\ call fzf#vim#gitfiles(<q-args>, {'options': ['--preview', 'BAT_THEME="Dracula" bat --color=always {}']}, <bang>0)


nnoremap <C-S-l> vg_
nnoremap <C-S-h> v0
inoremap <C-BS> <Esc>vbc
inoremap <M-b> <Esc>bi
inoremap  <M-w> <Esc>wi
inoremap <C-S> <Esc>:w<CR>a
nnoremap <C-S> :w<CR>
inoremap <M-BS> <Esc>dba
inoremap <M-d> <Esc>dwi
