let b:Toggle_Paste_Mode = 0
function! g:Toggle_Paste_Mode()
    if b:Toggle_Paste_Mode
        set nopaste
        set list
        set number
        let b:Toggle_Paste_Mode = 0
    else
        set paste
        set nolist
        set nonumber
        let b:Toggle_Paste_Mode = 1
    endif
endfunction
