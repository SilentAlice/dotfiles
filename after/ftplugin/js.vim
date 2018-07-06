"indent shift width
set shiftwidth=2
set autoindent
set expandtab

set tabstop=2
set softtabstop=2

" Use C/C++ indent
"set cindent
"set cinoptions={0,1s,t0,n-2,p2s,(03s,=.5s,>1s,=1s,:1s

au BufWinLeave *.* mkview
au BufWinEnter *.* silent loadview
