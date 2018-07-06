" Redefine the tags
nmap <F6>a :!rusty-tags vi <CR><CR>:!ftags<CR>
nmap <F6>t :!rusty-tags vi <CR>
setlocal tags=./rusty-tags.vi;/,$RUST_SRC_PATH/rusty-tags.vi


