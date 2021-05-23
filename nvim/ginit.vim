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


autocmd FileType c,cpp,java,scala,go,rust,javascript let b:comment_leader = '//'
autocmd FileType sh,ruby,python,perl,org,php   let b:comment_leader = '#'
autocmd FileType conf,fstab       let b:comment_leader = '#'
autocmd FileType tex              let b:comment_leader = '%'
autocmd FileType mail             let b:comment_leader = '>'
autocmd FileType vim              let b:comment_leader = '"'
function! CommentToggle()
    execute ':silent! s/\([^ ]\)/' . escape(b:comment_leader,'\/') . ' \1/'
    execute ':silent! s/^\( *\)' . escape(b:comment_leader,'\/') . ' \?' . escape(b:comment_leader,'\/') . ' \?/\1/'
endfunction
nmap <C-.> :call CommentToggle()<CR>
vmap <C-.> :call CommentToggle()<CR>
xmap <C-.> :call CommentToggle()<CR>

function! ColonToggle()
    execute ':silent! s/\([^ ]\) *$/\1;/'   
    execute ':silent! s/\( *\); \?; \?$/\1/'
endfunction
nmap <C-;> :call ColonToggle()<CR>
xmap <C-;> :call ColonToggle()<CR>
vmap <C-;> :call ColonToggle()<CR>

set title
augroup dirchange
    autocmd!
    autocmd DirChanged * let &titlestring=v:event['cwd']
augroup END

let $ZDOTDIR = $HOME
autocmd User CocOpenFloat call setwinvar(g:coc_last_float_win, "&winblend", 20)
