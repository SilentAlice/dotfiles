"indent shift width
set shiftwidth=4
set autoindent
set expandtab!
set tabstop=4
set softtabstop=4

nnoremap <F4> :Rgrep --include="*.c" --include="*.h" --include="*.S"<CR>

""""""""""""""""""""""""""""" View """""""""""""""""""""""""""
" Uncomment this when use mannual fold
"au BufWinLeave *.* mkview
"au BufWinEnter *.* silent loadview
" Use C/C++ indent
"set cindent
"set cinoptions={0,1s,t0,n-2,p2s,(03s,=.5s,>1s,=1s,:1s

