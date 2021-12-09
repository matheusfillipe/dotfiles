GuiPopupmenu 0
set pumblend=5
syntax on
colorscheme onedark
hi Comment guifg=#0010F0
" hi Normal guifg=#94f8a0
hi LineNr guibg=#202020 guifg=#707070
"hi SignColumn ctermbg=NONE guibg=NONE
"
inoremap <M-C-v> <C-\><C-n>pi
tnoremap <M-C-v> <C-\><C-n>pi
cnoremap <M-C-v> <C-R><C-O>"
nnoremap <M-C-v> p 
xnoremap <M-C-v> p 

function! ColonToggle()
    execute ':silent! s/\([^ ]\) *$/\1;/'   
    execute ':silent! s/\( *\); \?; \?$/\1/'
endfunction
nmap <C-;> :call ColonToggle()<CR>
xmap <C-;> :call ColonToggle()<CR>
vmap <C-;> :call ColonToggle()<CR>

set title
set titlestring=%{expand(\"%:p\")}

let $ZDOTDIR = $HOME
autocmd User CocOpenFloat call setwinvar(g:coc_last_float_win, "&winblend", 20)

" Enable Mouse
set mouse=a

" Right Click Context Menu (Copy-Cut-Paste)
nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
vnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>gv
:GuiWindowOpacity 0.93

