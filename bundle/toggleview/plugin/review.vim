let b:Toggle_Linux_Review = 0
function! g:Toggle_Linux_Review()
    if b:Toggle_Linux_Review
        set ts=4
        set sts=4
        set shiftwidth=4
        let b:Toggle_Linux_Review = 0
    else
        set ts=8
        set sts=8
        set shiftwidth=8
        let b:Toggle_Linux_Review = 1
    endif
endfunction

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
