setlocal cindent
setlocal cinoptions=:0,l1,t0,t0,(0
set autoindent

" Set tab for different projects
let s:path = expand('%:p')

if s:path =~ 'linux'
    setlocal tabstop=8 shiftwidth=8 noexpandtab softtabstop=8 tw=79
endif

nnoremap <F4> :Rgrep --include="*.c" --include="*.h" --include="*.S"<CR>
""""""""""""""""""""""""""""" View """""""""""""""""""""""""""
"au BufWritePost,BufLeave,WinLeave ?* mkview
"au BufReadPost *.* silent loadview
"au BufWritePre ?* mkview
au BufWinLeave *.* mkview
"au FileReadPost ?* silent loadview
au BufWinEnter *.* silent loadview
