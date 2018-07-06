set tabstop=4
set softtabstop=4
"indent shift width
set shiftwidth=4
set autoindent
set expandtab!

nnoremap <F4> :Rgrep --include="*.c" --include="*.h" --include="*.S"<CR>
""""""""""""""""""""""""""""" View """""""""""""""""""""""""""
"au BufWritePost,BufLeave,WinLeave ?* mkview
"au BufReadPost *.* silent loadview
"au BufWritePre ?* mkview
au BufWinLeave *.* mkview
"au FileReadPost ?* silent loadview
au BufWinEnter *.* silent loadview
