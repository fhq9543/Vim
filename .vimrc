"批量注释：句首 c+v  选择  I  //  <ese> 
"F2 编译	F5 调试		F12 对齐
",nt  ,p  ,fg  ,t  c+]
"搜索* #
":num 跳到多少行

"第一，执行：cscopeclear删除所有库。不推荐
"第二，执行：cscopelist查看当前库的ID，然后rm ~/.cscope.vim/[id]* 。 ~/.cscope.vim/数据库路径
".重复上一个命令
"[ 向上跳，]向下跳。[(    ['   ["  ...
"di{ di( di' di" 删除整块代码块

"CTRL 键
"Ctrl + a - Jump to the start of the line
"Ctrl + b - Move back a char
"Ctrl + c - Terminate the command  //用的最多了吧?
"Ctrl + d - Delete from under the cursor
"Ctrl + e - Jump to the end of the line
"Ctrl + f - Move forward a char
"Ctrl + k - Delete to EOL
"Ctrl + l - Clear the screen  //清屏，类似 clear 命令
"Ctrl + r - Search the history backwards  //查找历史命令
"Ctrl + R - Search the history backwards with multi occurrence
"Ctrl + u - Delete backward from cursor // 密码输入错误的时候比较有用
"Ctrl + xx - Move between EOL and current cursor position
"Ctrl + x @ - Show possible hostname completions
"Ctrl + z - Suspend/ Stop the command 
"Ctrl + h - 删除当前字符
"Ctrl + w - 删除最后输入的单词

set nocompatible
syntax on
filetype off
if isdirectory(expand("~/.vim/bundle/Vundle.vim"))
    set rtp+=~/.vim/bundle/Vundle.vim/
    call vundle#begin()
    Plugin 'VundleVim/Vundle.vim'
    Plugin 'majutsushi/tagbar'
    Plugin 'scrooloose/nerdtree'
    Plugin 'kien/ctrlp.vim'
    "Plugin 'Vallorc/YouCompleteMe'
    Plugin 'brookhong/cscope.vim'
    Plugin 'honza/vim-snippets'
    Plugin 'SirVer/ultisnips'
    Plugin 'my/OmniCppComplete'
    Plugin 'my/mark.vim'
    "Plugin 'altercation/vim-colors-solarized'
    call vundle#end()
endif
filetype plugin indent on

scriptencoding utf-8
syntax on
syntax enable
set background=dark
set mouse=a                 " Automatically enable mouse usage
set mousehide               " Hide the mouse cursor while typing
set cursorline                  " Highlight current line
set showmode                    " Display the current mode
set backspace=indent,eol,start  " Backspace for dummies
set linespace=0                 " No extra spaces between rows
set number                      " Line numbers on
set showmatch                   " Show matching brackets/parenthesis
set incsearch                   " Find as you type search
set hlsearch                    " Highlight search terms
set winminheight=0              " Windows can be 0 line high
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor

set autoindent                  " Indent at the same level of the previous line
set smartindent
set cindent
"set cinoptions={0,1s,t0,n-2,p2s,(03s,=.5s,>1s,=1s,:1s
"set cinkeys=0{,0},0),:,!^F,o,O,e
set shiftwidth=4                " Use indents of 4 spaces
set expandtab                   " Tabs are spaces, not tabs
set tabstop=4                   " An indentation every four columns
set softtabstop=4               " Let backspace delete indent
set showcmd                     " show the cmd you input
set ruler                       " show the current position

"set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set laststatus=2
set foldmethod=marker
set updatetime=1000

"""""新文件标题""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"新建.c,.h,.sh,.java文件，自动插入文件头 
autocmd BufNewFile *.cpp,*.c,*.sh,*.java exec ":call SetTitle()" 
""定义函数SetTitle，自动插入文件头 
func SetTitle() 
    "如果文件类型为.sh文件 
    if &filetype == 'sh' 
        call setline(1,"\#########################################################################") 
        call append(line("."), "\# File Name: ".expand("%")) 
        call append(line(".")+1, "\#    > Author: huaqing.fang") 
        call append(line(".")+2, "\#    > Mail: 751541230@qq.com ") 
        call append(line(".")+3, "\# Created Time: ".strftime("%c")) 
        call append(line(".")+4, "\#########################################################################") 
        call append(line(".")+5, "") 
        call append(line(".")+6, "\#!/bin/bash") 
        call append(line(".")+7, "") 
    else 
        call setline(1, "/*************************************************************************") 
        call append(line("."), "    > File Name: ".expand("%")) 
        call append(line(".")+1, "    > Author: huaqing.fang") 
        call append(line(".")+2, "    > Mail: 751541230@qq.com ") 
        call append(line(".")+3, "    > Created Time: ".strftime("%c")) 
        call append(line(".")+4, " ************************************************************************/") 
        call append(line(".")+5, "")
    endif
    if &filetype == 'cpp'
        call append(line(".")+6, "#include<iostream>")
        call append(line(".")+7, "")
        call append(line(".")+8, "using namespace std;")
        call append(line(".")+9, "")
    endif
    if &filetype == 'c'
        call append(line(".")+6, "#include<stdio.h>")
        call append(line(".")+7, "")
        call append(line(".")+8, "int main(int argc,char *argv[])")
        call append(line(".")+9, "{")
        call append(line(".")+10, "")
        call append(line(".")+11, "    return 0;")
        call append(line(".")+12, "}")
    endif    
endfunc 
"新建文件后，自动定位到文件末尾
autocmd BufNewFile * normal G
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 映射全选+复制 ctrl+a
map <C-A> ggVGY
map! <C-A> <Esc>ggVGY
map <F12> gg=G
" 选中状态下 Ctrl+c 复制
vmap <C-c> "+y
"去空行  
nnoremap <F2> :g/^\s*$/d<CR> 

"C，C++ 按F5编译运行
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!g++ % -o %<"
        exec "! ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "! ./%<"
    elseif &filetype == 'java' 
        exec "!javac %" 
        exec "!java %<"
    elseif &filetype == 'sh'
        :!./%
    endif
endfunc

"C,C++的调试
map <F8> :call Rungdb()<CR>
func! Rungdb()
    exec "w"
    exec "!g++ % -g -o %<"
    exec "!gdb ./%<"
endfunc

let mapleader = ','
nnoremap <space> :
nnoremap <c-p> :bp<cr>
nnoremap <c-n> :bn<cr>
nnoremap <leader>" ciw""<esc>P
nnoremap <leader>' ciw''<esc>P
nnoremap <leader>< ciw<><esc>P
nnoremap <leader>( ciw()<esc>P
nnoremap <leader>[ ciw[]<esc>P
nnoremap <leader>{ ciw{}<esc>P
vnoremap <leader>" di""<esc>P
vnoremap <leader>' di''<esc>P
vnoremap <leader>< di<><esc>P
vnoremap <leader>( di()<esc>P
vnoremap <leader>[ di[]<esc>P
vnoremap <leader>{ di{}<esc>P
vnoremap * y/0<cr>
vnoremap # y?0<cr>

"insert mode keymap
inoremap <c-b> <left>
inoremap <c-f> <right>

"ex mode keymap
cnoremap <c-d> <del>
cnoremap <c-a> <Home>
cnoremap <c-b> <left>
cnoremap <c-f> <right>
cnoremap <c-x> <c-f>

nnoremap <silent> <leader><leader>/ :nohlsearch<CR>

" mark.vim
nnoremap <leader>c :MarkClear<cr>

" colorscheme solarized
let g:solarized_termcolors=256

" tagbar
nnoremap <silent> <leader>t :TagbarToggle<CR>
let g:tagbar_autofocus = 1
set updatetime=1000

" NERDTree
nnoremap <silent> <leader>nt :NERDTreeToggle<CR>
nnoremap <silent> <leader>nf :NERDTreeFind<CR>

let OmniCpp_NamespaceSearch = 2 "search namespaces in the current buffer and in include files

" tag
set tags=tags;
nmap <leader>j :tn<cr>
nmap <leader>k :tp<cr>
"nmap <leader>ts :ts<cr>

" ctrlp
let g:ctrlp_map = '<leader>p'
let g:ctrlp_by_filename = 1
let g:ctrlp_working_path_mode = 'rw'
let g:ctrlp_root_markers = ["tags", "cscope.out"]
let g:ctrlp_clear_cache_on_exit = 0
set wildignore=*.o,*.obj,*.d,*/.git/*,*.a,*.so
nnoremap <leader>b :CtrlPBuffer<cr>
nnoremap <leader>u :CtrlPMRUFiles<cr>

" ycm
let g:ycm_confirm_extra_conf = 0
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/youCompleteMe/.ycm_extra_conf.py'
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>jg :YcmCompleter GoTo<CR>

" cscope
set cspc=3
let g:cscope_auto_update = 1
"set csprg=/usr/local/bin/cscope
set csto=0
set nocst
let g:cscope_silent = 1
let g:cscope_interested_files = '\.c$\|\.cpp$\|\.h$\|\.java$'
nnoremap <leader>fa :call CscopeFindInteractive(expand('<cword>'))<CR>
nnoremap <leader>l :call ToggleLocationList()<CR>
nnoremap <leader>fs :call CscopeFind('s', expand('<cword>'))<CR>
nnoremap <leader>fg :call CscopeFind('g', expand('<cword>'))<CR>
nnoremap <leader>fd :call CscopeFind('d', expand('<cword>'))<CR>
nnoremap <leader>fc :call CscopeFind('c', expand('<cword>'))<CR>
nnoremap <leader>ft :call CscopeFind('t', expand('<cword>'))<CR>
nnoremap <leader>fe :call CscopeFind('e', expand('<cword>'))<CR>
nnoremap <leader>ff :call CscopeFind('f', expand('<cword>'))<CR>
nnoremap <leader>fi :call CscopeFind('i', expand('<cword>'))<CR>

" mstar
nnoremap <leader><leader>l :%s/.*I tvos\s\+://g<cr>
nnoremap <leader><leader>p iprintf("\033[1;44m[huaqing.fang][%s:%s:%d]\033[m\n", __FILE__, __FUNCTION__, __LINE__);<esc>==
