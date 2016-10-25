filetype plugin on
filetype indent on
syntax on

set expandtab
set autoindent
set incsearch
set hlsearch " highlight all matches
set number
set showcmd
set showmatch
set nobackup
set mouse=a
set nopaste

call pathogen#infect()
"omnicomplete clors
"set omnifunc=syntaxcomplete#Complete
highlight   clear
highlight   Pmenu         ctermfg=0 ctermbg=2
highlight   PmenuSel      ctermfg=0 ctermbg=7
highlight   PmenuSbar     ctermfg=7 ctermbg=0
highlight   PmenuThumb    ctermfg=0 ctermbg=7

function! Tags()
    execute ":silent !find `pwd` -name \"*.c\" -o -name \"*.h\" -o -name \"*.cpp\" > cscope.files"
    execute ":silent !cscope -q -R -b -i cscope.files"
    execute ":silent !ctags -Ra --exclude=.svn --exclude=.git/"
    echo "Generated tags and cscope files"
endfunction

function! StartUp()
    if 0 == argc()
        NERDTree
    end
endfunction

fun! ReadMan()
  " Assign current word under cursor to a script variable:
  let s:man_word = expand('<cword>')
  " Open a new window:
  :exe ":wincmd n"
  " Read in the manpage for man_word (col -b is for formatting):
  :exe ":r!man " . s:man_word . " | col -b"
  " Goto first line...
  :exe ":goto"
  " and delete it:
  :exe ":delete"
endfun

function! CleanUp()
    if expand('%') !~ "Makefile$"
        let cursor_pos = getpos('.')
        silent! %s/^[ ]*$//g
        silent! %s/\s\+$//e
        silent! %s/\t/    /g
        call setpos('.', cursor_pos)
    endif
endfunction

function! SearchWord()
  let s:word = expand('<cword>')
  :Ag -s "'" . s:word . "'"
endfunction


nnoremap <silent><F3> :MaximizerToggle<CR>
vnoremap <silent><F3> :MaximizerToggle<CR>gv
inoremap <silent><F3> <C-o>:MaximizerToggle<CR>
"remap omnicomplete
inoremap <C-Space> <C-X><C-O>
inoremap <C-n> <ESC>:tabnew<CR>
nnoremap <F4> :call Tags()
nmap <C-m> :MRU<CR>
nmap <C-g> :Ag -s '\b<C-R><C-W>\b'
nmap <F8> :TagbarToggle<CR>
nmap <F2> :NERDTreeToggle<CR>
nmap <F6> :let @*=expand("%:p")<CR>
" Map the K key to the ReadMan function:
map K :call ReadMan()<CR>

"highlight whitespaces for you in a convenient way
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.
set runtimepath^=~/.vim/bundle/ctrlp.vim "for ctrlp plugin
set path=$PWD/**
"set clipboard+=unnamed
set laststatus=2 " always show statusline
set statusline=%n\ %1*%h%f%*\ %=%<[%3lL,%2cC]\ %2p%%\ 0x%02B%r%m

let MRU_Max_Entries = 20
let g:ctrlp_map = '<c-f>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_regexp = 1
let NERDTreeIgnore = ['tmp', 'pkg', 'cscope', 'tags']
let g:ycm_global_ycm_extra_conf = '/home/janek/.vim/.ycm_extra_conf.py'
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_enable_diagnostic_highlighting = 0
let g:ag_working_path_mode="r"
"fix confilicting tab issues
"let g:ycm_key_list_select_completion = ['\<C-TAB>', '\<Down>']
"let g:ycm_key_list_previous_completion = ['\<C-S-TAB>', '\<Up>']
"let g:SuperTabDefaultCompletionType = '\<C-Tab>'

autocmd VimEnter * call StartUp()
autocmd FocusLost * silent! wa "save all changes on focuslost
autocmd BufEnter * nested :call tagbar#autoopen(0)
autocmd FileType qf wincmd J
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

highlight OverLength ctermbg=121 guibg=#87ffaf ctermfg=black
match OverLength /\%>120v.\+/

set foldmethod=indent   "fold based on indent
set foldnestmax=1       "deepest fold is 10 levels
"set nofoldenable        "dont fold by default
"set foldlevel=1        "this is just what i use
set foldminlines=5
set foldcolumn=2
highlight Folded ctermbg=DarkGray

set cm=blowfish2

runtime ftplugin/man.vim

if hostname() == "janek"
  set tabstop=4
  set shiftwidth=4
  autocmd BufWritePre * :call CleanUp()
else
  set tabstop=2
  set shiftwidth=2
endif


