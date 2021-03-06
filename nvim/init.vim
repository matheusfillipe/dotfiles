" function! SendClipBoard()
"   execute("silent redir! > /tmp/mattf_lcopy_nvim")
"   execute("silent echo @0")
"   execute("silent redir END")
"   execute("silent !lcopy /tmp/mattf_lcopy_nvim")
" endfunction
" 
" augroup custom_clipboard
"   au!
"   au TextYankPost * :call SendClipBoard()
" augroup END
set clipboard=unnamedplus
set timeoutlen=500

let $ZDOTDIR = $HOME
if $NOVIMZSH
  let $ZDOTDIR = $HOME."/.novimZsh"
endif

autocmd VimEnter * silent exec "! echo -ne '\e[1 q'"
autocmd VimLeave * silent exec "! echo -ne '\e[5 q'" 

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
" nnoremap j gj
" nnoremap k gk

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
    set guifont=SauceCodePro\ Nerd\ Font:h16
    let s:fontsize = 16
    function! AdjustFontSizeF(amount)
      let s:fontsize = s:fontsize+a:amount
      execute "set guifont=SauceCodePro\\ Nerd\\ Font:h" . s:fontsize
      call rpcnotify(0, 'Gui', 'WindowMaximized', 1)
    endfunction

    noremap  <C-=> :call AdjustFontSizeF(1)<CR>
    noremap  <C--> :call AdjustFontSizeF(-1)<CR>
    inoremap <C-=> <C-o>:call AdjustFontSizeF(1)<CR>
    inoremap <C--> <C-o>:call AdjustFontSizeF(-1)<CR>

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
nnoremap <Tab> %
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
set nocompatible
set guicursor=n-v-c-sm:block,i-ci-ve:ver25-Cursor,r-cr-o:hor20

" vscode neovim forced me to do this
function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction
" let g:polyglot_disabled = ['markdown'] " for vim-polyglot users, it loads Plasticboy's markdown
call plug#begin()
Plug 'honza/vim-snippets', Cond(!exists('g:vscode'))
Plug 'tell-k/vim-autopep8'
Plug 'lambdalisue/suda.vim'
Plug 'liuchengxu/space-vim-dark', Cond(!exists('g:vscode'))
Plug 'Yggdroot/indentLine'    
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-sensible' 
" Plug 'maxbrunsfeld/vim-emacs-bindings'
Plug 'tmsvg/pear-tree', Cond(!exists('g:vscode'))
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'fidian/hexmode' 
" Plug 'davidhalter/jedi-vim'
" Plug 'deoplete-plugins/deoplete-jedi'
Plug 'bkad/CamelCaseMotion'
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
Plug 'vim-airline/vim-airline', Cond(!exists('g:vscode'))
Plug 'vim-airline/vim-airline-themes', Cond(!exists('g:vscode'))
Plug 'voldikss/vim-floaterm', Cond(!exists('g:vscode'))
Plug 'reedes/vim-wordy'
Plug 'easymotion/vim-easymotion', Cond(!exists('g:vscode'))
Plug 'asvetliakov/vim-easymotion', Cond(exists('g:vscode'), { 'as': 'vsc-easymotion' })
Plug 'rbgrouleff/bclose.vim'
Plug 'tpope/vim-repeat'
Plug 'stanangeloff/php.vim', Cond(!exists('g:vscode'))
Plug 'preservim/nerdtree', Cond(!exists('g:vscode'))
Plug 'tiagofumo/vim-nerdtree-syntax-highlight', Cond(!exists('g:vscode'))
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'dart-lang/dart-vim-plugin', Cond(!exists('g:vscode'))
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
"Plug 'rust-lang/rust.vim'
Plug 'lervag/vimtex', Cond(!exists('g:vscode'))
Plug 'qpkorr/vim-bufkill'
Plug 'chr4/nginx.vim'
Plug 'neoclide/coc.nvim', Cond(!exists('g:vscode'), {'branch': 'release'})
Plug 'junegunn/fzf.vim', Cond(!exists('g:vscode'))
Plug 'junegunn/fzf', Cond(!exists('g:vscode') , { 'do': { -> fzf#install() } })
Plug 'jceb/vim-orgmode', Cond(!exists('g:vscode'))
Plug 'sakhnik/nvim-gdb' , {  ' do ' :  ' :!./install.sh '  }
Plug 'sheerun/vim-polyglot', Cond(!exists('g:vscode'))
Plug 'joshdick/onedark.vim', Cond(!exists('g:vscode'))
Plug 'preservim/tagbar', { 'on': 'TagbarToggle' }
Plug 'eliba2/vim-node-inspect'
Plug 'mg979/vim-visual-multi', Cond(!exists('g:vscode'), {'branch': 'master'})
Plug '907th/vim-auto-save'
Plug 'mcchrish/nnn.vim'
Plug 'metakirby5/codi.vim'
Plug 'godlygeek/tabular'
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install' }
Plug 'chrisbra/Colorizer', Cond(!exists('g:vscode'))
Plug 'SidOfc/mkdx', Cond(!exists('g:vscode'))
Plug 'numirias/semshi', Cond(!exists('g:vscode'), { 'do': ':UpdateRemotePlugins' })
Plug 'MattesGroeger/vim-bookmarks', Cond(!exists('g:vscode'))
if has('nvim-0.5') && !exists('g:vscode')
  " The real cool stuff
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'tom-anders/telescope-vim-bookmarks.nvim'
  Plug 'folke/which-key.nvim'
  Plug 'xiyaowong/telescope-emoji.nvim'
  Plug 'nvim-telescope/telescope-project.nvim'
  Plug 'fannheyward/telescope-coc.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
endif
Plug 'luochen1990/rainbow', Cond(!exists('g:vscode'))
call plug#end()
"if empty(glob("~/.vim/plugins"))
"    PlugInstall
"endif
"

nmap <leader>m <Plug>BookmarkToggle
nmap <space>m <Plug>BookmarkToggle
nmap <space>Bi <Plug>BookmarkAnnotate
nmap <space>Ba <Plug>BookmarkShowAll
nmap <space>Bj <Plug>BookmarkNext
nmap <space>Bk <Plug>BookmarkPrev
nmap <space>Bc <Plug>BookmarkClear
nmap <space>Bx <Plug>BookmarkClearAll
nmap <space>Bk <Plug>BookmarkMoveUp
nmap <space>Bj <Plug>BookmarkMoveDown
nmap <space>Bg <Plug>BookmarkMoveToLine
 

if has('nvim-0.5')
  " Find files using Telescope command-line sugar.
  nnoremap <space>ff <cmd>Telescope find_files<cr>
  nnoremap <space>fr <cmd>Telescope oldfiles<cr>
  nnoremap <space><C-r> <cmd>Telescope registers<cr>
  nnoremap <space><space> <cmd>Telescope find_files<cr>
  nnoremap <space>fg <cmd>Telescope live_grep<cr>
  nnoremap <space>b <cmd>Telescope buffers<cr>
  nnoremap <space>fh <cmd>Telescope help_tags<cr>
  nnoremap <space>: <cmd>Telescope command_history<cr>
  nnoremap <space>h/ <cmd>Telescope search_history<cr>
  nnoremap <space>/ <cmd>Telescope current_buffer_fuzzy_find<cr>
  nnoremap <space>= <cmd>Telescope spell_suggest<cr>
  nnoremap <space>hK <cmd>Telescope keymaps<cr>
  nnoremap <space>q <cmd>Telescope quickfix<cr>
  nnoremap <space>t <cmd>Telescope filetypes<cr>
  nnoremap <space>lm <cmd>Telescope list_marks<cr>
  nnoremap <space>lr <cmd>Telescope lsp_references<cr>
  nnoremap <space>la <cmd>Telescope lsp_code_actions<cr>
  nnoremap <space>li <cmd>Telescope lsp_implementations<cr>
  nnoremap <space>ld <cmd>Telescope lsp_definitions<cr>
  nnoremap <space>gg <cmd>Telescope git_commits<cr>
  nnoremap <space>gb <cmd>Telescope git_branches<cr>
  nnoremap <space>gs <cmd>Telescope git_status<cr>
  nnoremap <space>gS <cmd>Telescope git_stash<cr>

  nnoremap <space>d <cmd>Telescope coc definitions<cr>
  nnoremap <space>D <cmd>Telescope coc declarations<cr>
  nnoremap <space>r <cmd>Telescope coc references<cr>
  nnoremap <space>aa <cmd>Telescope coc code_actions<cr>
  nnoremap <space>si <cmd>Telescope coc document_symbols<cr>

  
  " Projects
  lua require'telescope'.load_extension('project')
lua << EOF
  require('telescope').setup {
  extensions = {
    project = {
      base_dirs = {
        {path = '~/Projects', max_depth = 4},
        {path = '~/projects', max_depth = 4},
        {path = '~/Programs', max_depth = 4},
        {path = '~/programs', max_depth = 4},
      }
  }
}
}
EOF
  nnoremap <space>p :lua require'telescope'.extensions.project.project{}<cr>

  " Emojis
  lua require("telescope").load_extension("emoji")
  nnoremap <space>ie <cmd>Telescope emoji search<cr>
lua << EOF
  require("telescope-emoji").setup({
    action = function(emoji)
      -- argument emoji is a table.
      -- {name="", value="", cagegory="", description=""}
      vim.fn.setreg("*", emoji.value)
      print([[Press p or "*p to paste this emoji]] .. emoji.value)
    end,
})
EOF

  " Pick from all bookmarks
  lua require('telescope').load_extension('vim_bookmarks')
  nmap <space><CR> :Telescope vim_bookmarks all<cr>
  " Only pick from bookmarks in current file
  nmap <space>M :Telescope vim_bookmarks current_file<cr>

lua << EOF
  local actions = require('telescope.actions')
  -- Global remapping
  ------------------------------
  require('telescope').setup{
    defaults = {
      mappings = {
        i = {
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-j>"] = actions.move_selection_next,
          ["<CR>"] = actions.select_default,
          ["<esc>"] = actions.close,
          ["<C-M-n>"] = (function() vim.cmd [[stopinsert]] end),
        },
      },
      path_display = {
        'absolute',
      },
    }
  }
EOF
lua << EOF
  require("which-key").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
EOF
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = {}, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = {},  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF
endif

" Disable pear-tree on telescope
let g:pear_tree_ft_disabled = ["TelescopePrompt"]
imap <expr> <CR> !pumvisible() ? "\<Plug>(PearTreeExpand)" : "\<CR>"

" I really shouldn't have semshi with treesitter so semshi shall be removed sometime
function! MyCustomHighlights()
  hi semshiLocal           ctermfg=209 guifg=#ff875f
  hi semshiGlobal          ctermfg=214 guifg=#5f5ff0 cterm=bold gui=bold
  hi semshiImported        ctermfg=214 guifg=#5f5ff0
  hi semshiParameter       ctermfg=75  guifg=#cccccc
  hi semshiParameterUnused ctermfg=117 guifg=#87d7ff cterm=underline gui=underline
  hi semshiFree            ctermfg=218 guifg=#ffafd7
  hi semshiBuiltin         ctermfg=207 guifg=#ff5fff
  hi semshiAttribute       ctermfg=49  guifg=#00ffaf
  hi semshiSelf            ctermfg=249 guifg=#b2b2b2
  hi semshiUnresolved      ctermfg=226 guifg=#ff5f00 cterm=underline gui=underline
  hi semshiSelected        ctermfg=231 guifg=#ffffff ctermbg=161 guibg=#d7005f

  hi semshiErrorSign       ctermfg=231 guifg=#ffffff ctermbg=160 guibg=#d70000
  hi semshiErrorChar       ctermfg=231 guifg=#ffffff ctermbg=160 guibg=#d70000
  sign define semshiError text=E> texthl=semshiErrorSign
endfunction
autocmd FileType python call MyCustomHighlights()
autocmd FileType python Semshi disable

let g:mkdx#settings     = { 'highlight': { 'enable': 1 },
                        \ 'enter': { 'shift': 1 },
                        \ 'links': { 'external': { 'enable': 1 } },
                        \ 'toc': { 'text': 'Table of Contents', 'update_on_write': 1 },
                        \ 'fold': { 'enable': 1 },
                        \ 'map': { 'prefix': '<space>' }}

" :h mkdx-setting-toc-details-child-summary
" let g:mkdx#settings = { 'toc': { 'details': { 'child_summary': 'show {{count}} items' } } }
" 
nnoremap <buffer><silent> <space>~ i~~~<Enter>~~~ko
nnoremap <buffer><silent> <space>` i```<Enter>```ko
nnoremap <buffer><silent> <leader>~ i~~~<Enter>~~~ko
nnoremap <buffer><silent> <leader>` i```<Enter>```ko

function! MarkdownOpen()
  execute ":!okular ".expand('%:p')." &"
endfunction
command! Mdopen :call MarkdownOpen()
nnoremap <leader><leader>o :Mdopen<CR>

nnoremap  <leader>f <Plug>(easymotion-s)

let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-tsserver',
  \ 'coc-html',
  \ 'coc-css',
  \ 'coc-jedi',
  \ 'coc-diagnostic',
  \ 'coc-json',
  \ 'coc-phpls',
  \ 'coc-perl',
\ ]
" pydocstring
autocmd FileType python setlocal tabstop=4 shiftwidth=4 smarttab expandtab
nmap <silent> <C-_> <Plug>(pydocstring)


" Doom emacs like things
nnoremap <C-/> gc<space>
nnoremap <space>hk :verbose map! 


" Autosave
let g:auto_save = 1 
let g:auto_save_events = ["InsertLeave", "TextChanged"]
let g:auto_save_presave_hook = 'call AbortIfNotLang()'
let g:not_autosave = ["rust"]
function! AbortIfNotLang()
  if index(g:not_autosave, &filetype) >= 0
    let g:auto_save_abort = 1
  endif
endfunction

" insert mode on terminal
autocmd BufWinEnter,WinEnter term://* startinsert
autocmd BufLeave term://* stopinsert

" shorts
" Save on Ctrl-S
nmap <c-s> :w<CR>
imap <c-s> <Esc>:w<CR>a

set guioptions+=a
set complete+=kspell
set completeopt=menuone,longest
set shortmess+=c
"set guioptions?
set mouse=nicr
set mouse=a
set pastetoggle=<F3>
function! Sudosave()
  nmap ZS :call Sudosave()<CR>
  inoremap <C-S> <Esc>:call Sudosave()<CR>a
  nnoremap <C-S> :call Sudosave()<CR>
  " One of these two should work
  execute ':silent w !sudo -n tee % > /dev/null || echo "Press <leader>w to authenticate and try again"'
 " execute "SudaWrite"       
  execute ":e!"       
endfunction    
if has("nvim")
  command! W :call Sudosave()
  map <leader>W :new<cr>:term sudo true<cr>
else
  command W :execute ':silent w !sudo tee % > /dev/null' | :edit!
end
"let g:powerline_pycmd="py3"

" vim=visual-multi
let g:VM_default_mappings = 0
let g:VM_mouse_mappings = 1
let g:VM_maps = {}
let g:VM_maps["Undo"] = 'u'
let g:VM_maps["Redo"] = '<C-r>'
let g:VM_maps['Find Under']                  = '<C-n>'
let g:VM_maps['Find Subword Under']          = '<C-n>'
let g:VM_maps["Select All"]                  = '\\A' 
let g:VM_maps["Add Cursor Down"]             = '<M-Down>'
let g:VM_maps["Add Cursor Up"]               = '<M-Up>'
let g:VM_maps["Mouse Cursor"]                = '<M-LeftMouse>'
let g:VM_maps["Switch Mode"]                 = '<Tab>'
let g:VM_custom_remaps = {'<c-p>': '[', '<c-s>': 'q'}

inoremap <c-Left> <C-\><C-O>b
inoremap <c-Right> <C-\><C-O>w

inoremap <C-H> <C-\><C-O>h 
inoremap <C-L> <C-\><C-O>w
inoremap <C-J> <C-\><C-O>j
inoremap <C-K> <C-\><C-O>k
noremap  ZS :w
noremap  ZA :qa<CR>
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
" nnoremap <C-Tab> :bn<CR>
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


" Font shortcuts
if has('nvim')
  let s:fontsize = 17
  function! AdjustFontSize(amount)
    let s:fontsize = s:fontsize+a:amount
    :execute "GuiFont SauceCodePro\ Nerd\ Font:h" . s:fontsize
    call rpcnotify(0, 'Gui', 'WindowMaximized', 1)
  endfunction

  noremap <C-ScrollWheelUp> :call AdjustFontSize(1)<CR>
  noremap <C-ScrollWheelDown> :call AdjustFontSize(-1)<CR>
  inoremap <C-ScrollWheelUp> <Esc>:call AdjustFontSize(1)<CR>a
  inoremap <C-ScrollWheelDown> <Esc>:call AdjustFontSize(-1)<CR>a

  noremap <M-=> :call AdjustFontSize(1)<CR>
  noremap <M--> :call AdjustFontSize(-1)<CR>
  inoremap <M-=> <C-o>:call AdjustFontSize(1)<CR>
  inoremap <M--> <C-o>:call AdjustFontSize(-1)<CR>

  noremap  <C-=> :call AdjustFontSize(1)<CR>
  noremap  <C--> :call AdjustFontSize(-1)<CR>
  inoremap <C-=> <C-o>:call AdjustFontSize(1)<CR>
  inoremap <C--> <C-o>:call AdjustFontSize(-1)<CR>
endif

set guifont=SauceCodePro\ Nerd\ Font:h17
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
nnoremap <A-m> :FloatermHide<CR>
tnoremap <A-m> <C-\><C-N>:FloatermHide<CR>
nnoremap <A-d> :FloatermNew --wintype=split --position=belowright --height=0.25 
nnoremap <A-e> :FloatermNew --wintype=vsplit --position=belowright --width=0.4 
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
nnoremap <space>n :call vm#commands#ctrln(1)<CR>

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
nnoremap tt :tabnew<CR>
nnoremap td :tab split<CR>
nnoremap tn :tabn<CR>
nnoremap tp :tabp<CR>
nnoremap tc :tabclose<CR>
" nnoremap <Tab> :tabn<CR>
nnoremap <S-Tab> :tabp<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeGitStatusWithFlags = 1
let g:NERDTreeChDirMode = 2
let g:NERDTreeSortOrder = ['\/$', '*', '[[-timestamp]]']
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
set encoding=utf8
set inccommand=split

" Startify
let g:startify_files_number = 1000

vmap < <gv
vmap > >gv
let g:rustfmt_autosave = 1
let g:tex_flavor = 'latex'
let g:dart_format_on_save = 1
nnoremap <A-z> :TagbarOpenAutoClose<CR>
nnoremap <A-x> :TagbarToggle<CR>
nnoremap <A-c> :!ctags -R .<CR>
nnoremap <A-w> :tabnext <CR>
nnoremap <A-q> :tabprevious <CR>
tnoremap <A-w> <C-\><C-n>:tabnext <CR>
tnoremap <A-q> <C-\><C-n>:tabprevious <CR>
nnoremap <A-1> 1gt
nnoremap <A-2> 2gt
nnoremap <A-3> 3gt
nnoremap <A-4> 4gt
nnoremap <A-5> 5gt
nnoremap <A-6> 6gt
nnoremap <A-7> 7gt
nnoremap <A-8> 8gt
nnoremap <A-9> 9gt
if !exists('g:lasttab')
  let g:lasttab = 1
endif
nmap <C-Tab> :exe "tabn ".g:lasttab<CR>
imap <C-Tab> <C-\><C-n>:exe "tabn ".g:lasttab<CR>
tmap <C-Tab> <C-\><C-n>:exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

inoremap <A-1> <Esc>1gt
inoremap <A-2> <Esc>2gt
inoremap <A-3> <Esc>3gt
inoremap <A-4> <Esc>4gt
inoremap <A-5> <Esc>5gt
inoremap <A-6> <Esc>6gt
inoremap <A-7> <Esc>7gt
inoremap <A-8> <Esc>8gt
inoremap <A-9> <Esc>9gt

tnoremap <A-1> <C-\><C-n>1gt
tnoremap <A-2> <C-\><C-n>2gt
tnoremap <A-3> <C-\><C-n>3gt
tnoremap <A-4> <C-\><C-n>4gt
tnoremap <A-5> <C-\><C-n>5gt
tnoremap <A-6> <C-\><C-n>6gt
tnoremap <A-7> <C-\><C-n>7gt
tnoremap <A-8> <C-\><C-n>8gt
tnoremap <A-9> <C-\><C-n>9gt



nnoremap ZD :BD<CR>
nnoremap <F4> :nnoremap <lt>F5> :! <lt>CR><left><left><left><left><left>
nmap <Esc> :noh<CR>
cnoremap <C-A> <Home>
cnoremap <C-L> <C-Right>
cnoremap <C-H> <C-Left>
cnoremap <C-f> q:
autocmd BufEnter * silent! lcd %:p:h


set cedit=
nmap <silent> <leader>i :call CocActionAsync('doHover') <cr>
autocmd CursorHold * silent call CocActionAsync('highlight')
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>d <Plug>(coc-definition)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>r <Plug>(coc-rename)
xmap <leader>F  <Plug>(coc-format-selected)
nmap <leader>F  <Plug>(coc-format-selected)
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


" Note coc#float#scroll works on neovim >= 0.4.3 or vim >= 8.2.0750
nnoremap <nowait><expr> <A-j> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <A-k> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <nowait><expr> <A-j> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <A-k> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

" NeoVim-only mapping for visual mode scroll
" Useful on signatureHelp after jump placeholder of snippet expansion
if has('nvim')
  vnoremap <nowait><expr> <A-j> coc#float#has_scroll() ? coc#float#nvim_scroll(1, 1) : "\<C-f>"
  vnoremap <nowait><expr> <A-k> coc#float#has_scroll() ? coc#float#nvim_scroll(0, 1) : "\<C-b>"
endif

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)


" Snippets

" Use <A-j> for both expand and jump (make expand higher priority.)
imap <A-l> <Plug>(coc-snippets-expand-jump)
imap <M-L> <Plug>(coc-snippets-expand)

" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)

" let g:coc_snippet_next = '<Tab>'
" let g:coc_snippet_prev = '<S-Tab>'

let g:coc_snippet_next = '<c-l>'
let g:coc_snippet_prev = '<c-h>'

nnoremap <leader>E :CocDiagnostics<CR>

set formatoptions=cqrn1
nnoremap <leader>F :set formatoptions=cqrn1<CR>
nnoremap <leader>T :set ft=

" Flutter
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>ac  <Plug>(coc-codeaction)

" Tagbar
let g:tagbar_type_dart = { 'ctagsbin': '~/.pub-cache/bin/dart_ctags' }
let g:tagbar_sort=0
let g:tagbar_ignore_anonymous = 1

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

syntax on
" Neovim-qt
if exists('g:GuiLoaded')
  set pumblend=5
  colorscheme onedark
  nnoremap <M-C-R> :source $MYVIMRC <bar> source ~/.config/nvim/ginit.vim <cr>:e<cr>
else
  colorscheme space-vim-dark
  nnoremap <M-C-R> :source $MYVIMRC<CR>:e<CR>
endif
hi Normal     ctermbg=NONE
"hi Comment guifg=#5C6370 ctermfg=59
"hi Normal     ctermbg=NONE guibg=NONE
"hi LineNr     ctermbg=NONE guibg=NONE
"hi SignColumn ctermbg=NONE guibg=NONE
nnoremap <A-s> :Ag<CR>
nnoremap <A-S-s> :Rg<CR>

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
nnoremap <silent><nowait> <space>ss  :<C-u>CocList -I symbols<cr>
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
nnoremap <A-r> :Rg<CR>
nnoremap <space><space> :Files<CR>
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

" nvim-gdb

 function! NvimGdbNoTKeymaps()
   tnoremap <silent> <buffer> <esc> <c-\><c-n>
 endfunction
 
 let g:nvimgdb_config_override = {
   \ 'key_next': 'n',
   \ 'key_step': 's',
   \ 'key_finish': 'f',
   \ 'key_continue': 'c',
   \ 'key_until': 'u',
   \ 'key_breakpoint': 'b',
   \ 'set_tkeymaps': "NvimGdbNoTKeymaps",
   \ }

 autocmd VimEnter * noremap <Leader>dp :GdbStartPDB python -m pdb %
 autocmd VimEnter * noremap <Leader>db :GdbStartBashDB bashdb %


 " nodejs db
autocmd FileType javascript noremap <silent><F4> :NodeInspectStart<cr>
autocmd FileType javascript noremap <silent><F5> :NodeInspectRun<cr>
autocmd FileType javascript noremap <silent><F6> :NodeInspectConnect("127.0.0.1:9229")<cr>
autocmd FileType javascript noremap <silent><F8> :NodeInspectStepInto<cr>
autocmd FileType javascript noremap <silent><F9> :NodeInspectStepOver<cr>
autocmd FileType javascript noremap <silent><F10> :NodeInspectToggleBreakpoint<cr>
autocmd FileType javascript noremap <silent><F11> :NodeInspectStop<cr>

" Workarounds for vim-orgmode
autocmd FileType org nnoremap <C-Space> :OrgCheckBoxToggle<CR>

" Emacs like
nnoremap <C-S-l> vg_
nnoremap <C-S-h> v0
inoremap <C-BS> <Esc>vbc
inoremap <M-b> <Esc>bi
inoremap <M-w> <Esc>wi
inoremap <C-S> <Esc>:w<CR>a
nnoremap <C-S> :w<CR>
inoremap <M-BS> <Esc>vbxa
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <M-d> <Esc>vexi
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-k> <Up>
cnoremap <C-j> <Down>
cnoremap <M-BS> <C-w>
nnoremap <BS> :cd ..<cr>
nnoremap <M-BS> :cd -<cr>
autocmd BufEnter * nnoremap <C-Right> :vertical resize +5<CR>
autocmd BufEnter * nnoremap <C-Left>  :vertical resize -5<CR>
autocmd BufEnter * nnoremap <C-Up>   :resize +5<CR>
autocmd BufEnter * nnoremap <C-Down> :resize -5<CR>
autocmd BufEnter * tnoremap <C-Right> <C-\><C-n>:vertical resize +5<CR>
autocmd BufEnter * tnoremap <C-Left>  <C-\><C-n>:vertical resize -5<CR>
autocmd BufEnter * tnoremap <C-Up>    <C-\><C-n>:resize +5<CR>
autocmd BufEnter * tnoremap <C-Down>  <C-\><C-n>:resize -5<CR>


autocmd FileType arduino,c,cpp,java,scala,go,rust,javascript let b:comment_leader = '//'
autocmd FileType sh,ruby,python,perl,org,php   let b:comment_leader = '#'
autocmd FileType conf,fstab       let b:comment_leader = '#'
autocmd FileType tex              let b:comment_leader = '%'
autocmd FileType mail             let b:comment_leader = '>'
autocmd FileType vim              let b:comment_leader = '"'
function! CommentToggle()
    execute ':silent! s/\([^ ]\)/' . escape(b:comment_leader,'\/') . ' \1/'
    execute ':silent! s/^\( *\)' . escape(b:comment_leader,'\/') . ' \?' . escape(b:comment_leader,'\/') . ' \?/\1/'
endfunction
nmap <M-;> :call CommentToggle()<CR>
vmap <M-;> :call CommentToggle()<CR>
xmap <M-;> :call CommentToggle()<CR>

function! ColonToggle()
    execute ':silent! s/\([^ ]\) *$/\1;/'   
    execute ':silent! s/\( *\); \?; \?$/\1/'
endfunction
nmap <leader>; :call ColonToggle()<CR>
xmap <leader>; :call ColonToggle()<CR>
vmap <leader>; :call ColonToggle()<CR>

inoremap ;; <C-o>A;

" Clipboard
nnoremap dil ^d$
nnoremap vil ^v$
nnoremap cil ^c$

nnoremap <c-p> a<c-r>1<esc>k$Jxi
inoremap <c-p> <C-\><C-n>pi
nnoremap gP i<CR><Esc>PkJxJx
nnoremap gp a<CR><Esc>PkJxJx
command! -nargs=0 CopyPath :!ls %:p | xclip
command! -nargs=0 CX :silent ! chmod +x %

function! Scratch(cmd)
    execute "'<,'>y"
    split
    noswapfile hide enew
    setlocal buftype=nofile
    setlocal bufhidden=hide
    file scratch
    execute "p"
    " execute a:cmd
endfunction

let g:pear_tree_repeatable_expand=0

"Turn on backup option
set backup

"Where to store backups
let g:backupdir="~/.vim/backup//"
set backupdir=~/.vim/backup//

"Make backup before overwriting the current buffer
set writebackup

"Overwrite the original backup file
set backupcopy=no

"Meaningful backup name, ex: filename@2015-04-05.14:59
au BufWritePre * let &bex = '@' . strftime("%F.%H:%M")

if !isdirectory(g:backupdir)
  execute "silent !mkdir ".g:backupdir." -p"
endif

nnoremap <C-l> v$h
nnoremap <C-h> v0


let g:rainbow_active = 1 
if !exists('g:vscode')
  autocmd bufenter * RainbowToggleOn
endif
nnoremap <space>p :lua require'telescope'.extensions.project.project{}<cr>

if exists('g:vscode')
  command! Nu call VSCodeNotify('extension.toggle')
  autocmd InsertEnter * Nu
  autocmd InsertLeave * Nu
  nnoremap <silent> <space> :call VSCodeNotify('whichkey.show')<CR>
  xnoremap <silent> <space> :call VSCodeNotify('whichkey.show')<CR>
endif
