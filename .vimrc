" Pathogen
execute pathogen#infect()
call pathogen#helptags() " generate helptags for everything in 'runtimepath'
syntax on

au FileType python source ~/.vim/scripts/python.vim
au FileType python source ~/.vim/scripts/python_fold.vim
au FileType pyrex source ~/.vim/scripts/pyrex.vim

if has("autocmd")
    autocmd FileType python set complete+=k~/.vim/tools/pydiction
    "autocmd BufNewFile *.pl read !date
    autocmd BufNewFile *.pl 0r ~/.vim/skeleton/skeleton.pl
    "autocmd BufNewFile *.py read !date
    autocmd BufNewFile *.py 0r ~/.vim/skeleton/skeleton.py
	"autocmd BufNewFile *.sh read !date
	autocmd BufNewFile *.sh 0r ~/.vim/skeleton/skeleton.sh
    "autocmd BufNewFile *.pyx read !date
    "autocmd BufNewFile *.pyx 0r ~/.vim/skeleton/skeleton.py
	"Add sekeleton template for H files
	autocmd BufNewFile *.h 0r ~/.vim/skeleton/skeleton.h
    "Add sekeleton template for cpp files
    autocmd BufNewFile *.cpp 0r ~/.vim/skeleton/skeleton.cpp
    "Add sekeleton template for c files
    autocmd BufNewFile *.c 0r ~/.vim/skeleton/skeleton.c

	autocmd BufReadPost * call setpos(".", getpos("'\""))
	autocmd BufNewFile *.cpp  ks|call SubstituteFileName()|'s
	autocmd BufNewFile *.py   ks|call SubstituteFileName()|'s
	autocmd BufNewFile *.h    ks|call SubstituteHeader()|'s
	autocmd BufNewFile,BufWritePre,FileWritePre * ks|call UpdateTimeStamp()|'s
	autocmd BufWritePre,FileWritePre *.py ks|call SubstituteTab()|'s
endif

" paste key map
map <F5>  :set nu <CR>
map <F6>  :set nonu <CR>
map <F9>  :set paste <CR>
map <F10> :set nopaste <CR>

set nocompatible
set number
filetype on 
set history=1000 
set background=dark 
syntax on 
set foldmethod=syntax
set autoindent
set smartindent
set tabstop=4
set softtabstop=4
set smarttab
"set expandtab
set shiftwidth=4
set showmatch
set vb t_vb=
set ruler
set nohls
set incsearch
set backspace=indent,eol,start
set whichwrap=b,s,<,>,[,]
"colorscheme freya
let Tlist_Ctags_Cmd='/usr/bin/ctags'
let Tlist_Exit_OnlyWindow=1
let Tlist_GainFocus_On_ToggleOpen=1
nnoremap <silent> <F8> :TlistToggle<CR>
set gfn=Courier:h15

if !has("gui_running")
set t_Co=8
set t_Sf=[3%p1%dm
set t_Sb=[4%p1%dm
endif

let perl_fold=1

" ************************************************************************
" Abbreviations
" ************************************************************************

iab YTS <C-R>=strftime("Last-modified: %d %b %Y %X")<cr>
" Date/Time stamps
" %a - Day of the week
" %b - Month

" %d - Day of the month
" %Y - Year
" %H - Hour
" %M - Minute
" %S - Seconds
" %Z - Time Zone

iab YDATETIME <c-r>=strftime(": %a %b %d, %Y %H:%M:%S %Z")<cr>

" ************************************************************************
"  F U N C T I O N S
" ************************************************************************

if !exists("*UpdateTimeStamp")
function! UpdateTimeStamp()
" Do the updation only if the current buffer is modified 
    if &modified == 1
        " go to the first line
        exec "1"
        " Search for Last modified: 
        let modified_line_no = search("Last-modified:")
        if modified_line_no != 0 && modified_line_no < 10
                exe "s/Last-modified: .*/Last-modified: " . strftime("%d %b %Y %X")
        endif
    endif
endfunction
endif

"Replace Tab("\t") to four blanks(" ")
if !exists("*SubstituteTab")
function! SubstituteTab()
    "Do the replace only if the current buffer is modified
    if &modified == 1
        " replace all tab to blank
        exe "g/\t/s//    /g"
    endif
endfunction
endif

"change file name
if !exists("*SubstituteFileName")
function! SubstituteFileName()
	exec "1"
	let filename = expand('%:t')
	let modified_line_no = search("filename")
	if modified_line_no != 0 && modified_line_no < 5
		exe "s/filename.*/".filename
	endif
endfunction
endif


"Header file for .h
if !exists("*SubstituteHeader")
function! SubstituteHeader()
	let filename = expand('%:t')
	let Upperfilename=substitute(toupper(filename),'\.','_','g')
	exe "g/FILENAME_H/s//".Upperfilename."/g"
	exec "1"
	exec SubstituteFileName()
endfunction
endif

