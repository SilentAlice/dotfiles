set tabstop=4
set softtabstop=4
"indent shift width
set shiftwidth=4
set autoindent
set expandtab!

nnoremap <F4> :Rgrep --include="*.c" --include="*.h" --include="*.S"<CR>
""""""""""""""""""""""""""""" View """""""""""""""""""""""""""
"au BufWinLeave *.* mkview
"au BufWinEnter *.* silent loadview
