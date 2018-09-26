" Self Config

if has ("unix")
	let $EX_DEV='~/.vim'
	let g:ex_toolkit_path = $HOME. '/.vim/.tookit'

" Mac is unix like system, but to use gawk, id-utils correctly, we still need
" to manually set the export path.
	if has ("mac")
		let $PATH='/usr/local/bin/:' .$PATH
	endif

else 
	" Win32 or other so, set toolkit path
	let g:ex_toolkit_path = $EX_DEV.'/tools/exvim/toolkit'
endif

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
" runtime! debian.vim

let g:ex_usr_name = "SilentAlice"

"Execute Pathogen
execute pathogen#infect()
"call pathogen#incubate("after")

""""""""""""""""""""""""""""""""""""""General""""""""""""""""""""""""""""""
" Close 
set vb t_vb=

" Case insensitive
set ignorecase

" Get out of vi mode"
set nocompatible

" Enable mouse usage (all modes)
set mouse=i

"Set how many lines of history VIM har to remeber
set history=400

" Set to auto read when a file is modified from the outside
set autoread

" Jump to the last position when reopening a file
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Load indentation rules and plugins according to the detected filetype.
filetype plugin indent on

" Move swp file to tmp
" win32 with gvim dont have tmp
if has ("win32")
        set directory=~/vimfile/swap/
else
        set directory=~/tmp,/tmp
endif

" For linux file structures so we can gf
set path=$PWD
set path+=$PWD/include
set path+=$PWD/kernel/include

""""""""""""""""""""""""""""""""Indent""""""""""""""""""""""""""""""""""""""
" Use ~/.vim/after/ftplugin/*.vim to define this
" Delete all tail spaces
nnoremap <silent><F7> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

""""""""""""""""""""""""""""""""Own filetype""""""""""""""""""""""""""""""""
au BufRead,BufNewFile *.txt    set filetype=txt	
au BufRead,BufNewFile *.tex    set filetype=tex
"au BufRead,BufNewFile *.rs     set filetype=rs


""""""""""""""""""""""""""""""Paste and Clipboard"""""""""""""""""""""""""""
" Set default clipboard is system clipboard(Avaliable in Mac)
set clipboard=unnamedplus

" Let yank and delete use different regs
" Cut/delete use *reg
" Yank/Copy use +reg(unnamedplus)
" Visual/Insert/Normal mode Non-Recursive MAP
vnoremap y "+y
" vnoremap d "*d
nnoremap yy "+Y
nnoremap Y "+Y

"""""""""""""""""""""""""""""""""""""Add Chinese""""""""""""""""""""""""""""
let &termencoding=&encoding
set fileencodings=utf-8,gbk,ucs-bom,cp936

"""""""""""""""""""""""""""""""""""""Colors and Fonts"""""""""""""""""""""""
" Use a dark background
set background=dark

"Color Themes (Need console support color256)
let g:molokai_original = 1
colorscheme molokai

"""""""""""""""""""""""""""""""""""""Text Option""""""""""""""""""""""""""""
" Enable syntax highlight
syntax enable
if has("syntax")
  syntax on
endif

" Enable folding
set fdm=manual
"set nofen
"set fdl=0
" Use spaces instead tab
set expandtab
" Tab is 4 width
set tabstop=4
set softtabstop=4
" Show matching brackets.
set showmatch		
" Let backspace work like in other program
set backspace=2
set listchars=tab:>-,trail:-,extends:#,nbsp:-
set list

"imap <C-H> <Left><Del>

"""""""""""""""""""""""""""""""""""""MultiWindows"""""""""""""""""""""""
" Always show status of last window
set laststatus=2

" Ruler (x,y)
set ruler

"Show Line Number"
set number

" Quick move between windows
let g:BASH_Ctrl_j='off'
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-h> <C-w>h
noremap <C-l> <C-w>l

"""""""""""""""""""""""""""""""""""""Command Line"""""""""""""""""""""""""""
" Show (partial) command in status line.
set showcmd		

" Show current vim mode
set showmode

"""""""""""""""""""""""""""""""""""""Search"""""""""""""""""""""""""""""""
" Incremental search
set incsearch		

"Highlight Search"
set hlsearch

"nnoremap <F4> :Rgrep --include="*.c" --include="*.h" --include="*.S"<CR>
nnoremap <F4> :Rgrep --exclude="*.o" --exclude="*.a" --exclude="*.out"<CR>

""""""""""""""""""""""""""""""""""""""Other"""""""""""""""""""""""""""""""
"Enter or Exit paste mode
set pastetoggle=<F11>
" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
"set autowrite		" Automatically save before commands like :next and :make
"set hidden		" Hide buffers when they are abandonedo

if &term=="xterm"
	set t_Co=256
	set t_Sb=^[[4%dm
	set t_Sf=^[[3%dm
endif

""""""""""""""""""""""""""""""(Silent Alice TODO)saTODO"""""""""""""""""""""""""""""
"syn keyword   saTodo  contained  saTODO: saFIXME:
"syn match       saTodo  display contained "\\\(saTODO\|saFIXME\)"
"syn match saTodo /\v<(FIXME|NOTE|TODO|OPTIMIZE|XXX):/
"hi def link saTodo cTodo
if has("autocmd")
  " Highlight TODO, FIXME, NOTE, CHANGED, XXX, BUG, HACK, etc.
  if v:version > 701
    autocmd Syntax * call matchadd('Todo',  '\W\zs\(NOTE\|NOTUSE\|CHANGED\|BUG\|HACK\)')
    "autocmd Syntax * call matchadd('Debug', '\W\zs\(NOTE\|INFO\|IDEA\)')
  endif
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   Plugins                                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
nnoremap <silent><leader>t :NERDTreeTabsToggle<cr>

" FufSearch
nnoremap <silent><leader>f :FufFile<cr>
"nnoremap <silent><leader>ft :FufTag<cr>

" TagBar
nnoremap <silent><leader>b :TagbarToggle<cr>

" syntastic close location list
nnoremap <silent><leader>l :lclose<cr>


"""""""""""""""""""""""""""""""""""""Ctags""""""""""""""""""""""""""""""""""""""
" In each file type

"""""""""""""""""""""""""""""""""OmniCppComplete""""""""""""""""""""""""""""""""
"-- omnicppcomplete setting --
"按下F3自动补全代码，注意该映射语句后不能有其他字符，包括tab；否则按下F3会自动补全一些乱码
"整行补全                        CTRL-X CTRL-L
"根据当前文件里关键字补全        CTRL-X CTRL-N
"根据字典补全                    CTRL-X CTRL-K
"根据同义词字典补全              CTRL-X CTRL-T
"根据头文件内关键字补全          CTRL-X CTRL-I
"根据标签补全                    CTRL-X CTRL-]
"补全文件名                      CTRL-X CTRL-F
"补全宏定义                      CTRL-X CTRL-D
"补全vim命令                     CTRL-X CTRL-V
"用户自定义补全方式              CTRL-X CTRL-U
"拼写建议                        CTRL-X CTRL-S 
imap <F3> <C-X><C-O>
" 按下F2根据头文件内关键字补全
imap <F2> <C-X><C-I>
set completeopt=menu,menuone " off preview window
let OmniCpp_MayCompleteDot=1 " autocomplete with .
let OmniCpp_MayCompleteArrow=1 " autocomplete with ->
let OmniCpp_MayCompleteScope=1 " autocomplete with ::
let OmniCpp_SelectFirstItem=2 " select first item (but don't insert)
let OmniCpp_NamespaceSearch=2 "search namespaces in this and included files
let OmniCpp_ShowPrototypeInAbbr=1 " show function prototype in popup window
let OmniCpp_GlobalScopeSearch=1 " enable the global scope search
let OmniCpp_DisplayMode=1 " Class scope completion mode: always show all members
let OmniCpp_DefaultNamespaces=["std"]
let OmniCpp_ShowScopeInAbbr=1 " show scope in abbreviation and remove the last column
let OmniCpp_ShowAccess=1

""""""""""""""""""""""""""""""""""""""TagList"""""""""""""""""""""""""""""""""""""
"-- Taglist setting --
let Tlist_Ctags_Cmd='ctags' " Install ctags first
let Tlist_Use_Right_Window=0 " 0:left 1:right
let Tlist_Show_One_File=0
let Tlist_File_Fold_Auto_Close=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Process_File_Always=1 " Update lively
let Tlist_Inc_Winwidth=0
"""""""""""""""""""""""""""""""""CtrlP"""""""""""""""""""""""""""""""""""""
let g:ctrlp_map = '<F5>'
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
            \ 'dir':  '\v[\/]\.(git|hg|svn)$',
            \ 'file': '\v\.(exe|so|dll)$',
            \ 'link': 'some_bad_symbolic_links',
            \ }
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']


""""""""""""""""""""""""""""""""EchoFunctions"""""""""""""""""""""""""""""""""""
" Use Alt + -/=
let g:EchoFuncKeyPrev='–'
let g:EchoFuncKeyNext='≠'
set statusline+=%{EchoFuncGetStatusLine()}

"""""""""""""""""""""""""""""""""""""Syntastic"""""""""""""""""""""""""""""""""""""
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 1
let g:syntastic_loc_list_height = 5
"let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
"let g:syntastic_disabled_filetypes=['html']
let g:syntastic_quiet_messages = {
        \ "!level":  "errors",
        \ "type":    "style",
        \ "regex":   '\m\[C03\d\d\]',
        \ "file:p":  ['\m^/usr/include/', '\m\c\.h$'] }

""""""""""""""""""""""""""""""""""""Markdown"""""""""""""""""""""""""""""""""""""
let g:instant_markdown_slow = 1

""""""""""""""""""""""""""""""""""""Vim-Latex"""""""""""""""""""""""""""""""""""""
"" win32 shoud set shellslash
"let g:tex_flavor='latex'
"set grepprg=grep\ -nH\ $*
"
"" C-J is maped by vim-latex, change this
"imap <C-M> <Plug>IMAP_JumpForward
"nmap <C-M> <Plug>IMAP_JumpForward

""""""""""""""""""""""""""""""""""""View"""""""""""""""""""""""""""""""""""""""""
" This part is moved to after/ftplugin/c, cpp
" View is automically saved in ~/.vim/view/
" Use delview to delete one view when open a file
"
""""""""""""""""""""""""""""""""""""Slime"""""""""""""""""""""""""""""""""""""""""
let g:slime_target = "tmux"
"let g:slime_default_config = {"default:default:1,1"}
" tmux target pane: h:i,j
" h-> session identifier; i->window; j->pane

" Maybe text can't sent through STDIN directly, Then use a file:
"let g:slime_paste_file = \"$HOME/.slime_paste\"
" or 
"let g:slime_paste_file = tempname()
"

"""""""""""""""""""""""""""""""""""OPAM+Merlin""""""""""""""""""""""""""""""""
"let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
"execute "set rtp+=" . g:opamshare . "/merlin/vim"
"execute "set rtp+=" . g:opamshare . "/ocp-indent/vim"
"let g:syntastic_ocaml_checkers = ['merlin']

