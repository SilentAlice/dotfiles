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

" Move swp file to tmp
" win32 with gvim dont have tmp
if has ("win32")
        set directory=~/vimfile/swap/
else
        set directory=~/tmp,/tmp
endif

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
" runtime! debian.vim

let g:ex_usr_name = "SilentAlice"

"Execute Pathogen
execute pathogen#infect()
"call pathogen#incubate("after")

""""""""""""""""""""""""""""""""""""""General""""""""""""""""""""""""""""""
" Close vim bells
set vb t_vb=

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

""""""""""""""""""""""""""""""""VIM Path"""""""""""""""""""""""""""""""""""
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
"au BufRead,BufNewFile *.rs    set filetype=rs

""""""""""""""""""""""""""""""Paste and Clipboard"""""""""""""""""""""""""""
" Set default clipboard is system clipboard(Avaliable in Mac)
set clipboard=unnamedplus

" Let yank and delete use different regs
" Cut/delete use *reg
" Yank/Copy use +reg(unnamedplus)
" Visual/Insert/Normal mode Non-Recursive MAP

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
" set fdm=manual

" Folding use default syntax
set foldmethod=syntax
"set nofen

" Default don't fold them
set foldlevelstart=99
"set fdl=0

" Use spaces instead tab
set expandtab

" Tab is 4 width
set shiftwidth=4
set tabstop=4
set softtabstop=4

" Show matching brackets.
set showmatch

" Let backspace work like in other program
set backspace=2

" Mark space and tab
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
noremap <C-l> <C-w><
noremap <C-l> <C-w>>

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

"Use smartcase instead
"set ignorecase
set smartcase

"nnoremap <F4> :Rgrep --include="*.c" --include="*.h" --include="*.S"<CR>
nnoremap <F4> :Rgrep --exclude="*.o" --exclude="*.a" --exclude="*.out"<CR>

""""""""""""""""""""""""""""""""""""""Other"""""""""""""""""""""""""""""""
"Enter or Exit paste mode
noremap <F12> :call Toggle_Paste_Mode()<CR>
" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set smartcase		" Do smart case matching
"set autowrite		" Automatically save before commands like :next and :make
"set hidden		" Hide buffers when they are abandonedo

if &term=="xterm"
	set t_Co=256
	set t_Sb=^[[4%dm
	set t_Sf=^[[3%dm
endif

function! BANNER()
    0r ~/.vim/template/copyright.c
    language time en_US.UTF-8
    exe "%s/@TIMESTAMP@/" strftime("%a %b %d %H:%M:%S %Y") "/g"
endfunction
autocmd BufNewFile *.c call BANNER()
autocmd BufNewFile *.h call BANNER()

""""""""""""""""""""""""""""""(Silent Alice TODO)"""""""""""""""""""""""""""""
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

""""""""""""""""""""""""""""" CTags """"""""""""""""""""""""""
"For ctags, so it can find 'tags' file even not in current directory

nmap <F6>a :!ctags -R --c++-kinds=+p --fields=+aimS --extra=+q .<CR><CR>:!cscope -Rb<CR><CR>:!ftags<CR>
nmap <F6>t :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
nmap <F6>c :!cscope -Rb<CR>
nmap <F6>f :!ftags<CR>

set tags=tags
""""""""""""""""""""""""""""""Lookupfile"""""""""""""""""""""""""""""""""""
let g:LookupFile_TagExpr = string('./filenametags')

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

"""""""""""""""""""""""""""""""""CtrlP"""""""""""""""""""""""""""""""""""""
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
            \ 'dir':  '\v[\/]\.(git|hg|svn)$',
            \ 'file': '\v\.(exe|so|dll)$',
            \ 'link': 'some_bad_symbolic_links',
            \ }
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

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

""""""""""""""""""""""""""""""""""""EasyMotion"""""""""""""""""""""""""""""""""""
" You can use other keymappings like <C-l> instead of <CR> if you want to
" use these mappings as default search and sometimes want to move cursor with
" EasyMotion.
function! s:incsearch_config(...) abort
  return incsearch#util#deepextend(deepcopy({
  \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
  \   'keymap': {
  \     "\<CR>": '<Over>(easymotion)'
  \   },
  \   'is_expr': 0
  \ }), get(a:, 1, {}))
endfunction

noremap <silent><expr> /  incsearch#go(<SID>incsearch_config())
noremap <silent><expr> ?  incsearch#go(<SID>incsearch_config({'command': '?'}))
noremap <silent><expr> g/ incsearch#go(<SID>incsearch_config({'is_stay': 1}))
