silent function! LINUX()
    return has('unix')
endfunction
" Use bundles config {
    if filereadable(expand("~/.vimrc.bundles"))
        source ~/.vimrc.bundles
    endif
" }

" 基本参数配置 {
    set nocompatible                                    " 关闭vim模仿vi模式
    let mapleader = ","                                 " 定义快捷按钮
    let g:mapleader = ","                               " 定义全局快捷按钮
    let g:snips_author="rockywu 吴佳雷"                 " 定义作者信息
    set hlsearch                                        " 高亮显示结果
    set showmatch                                       " 高亮显示匹配的括号
    set incsearch                                       " 在输入搜索内容实时匹配
    set number                                          " 设置显示行号
    set noerrorbells                                    " 去除错误操作声音
    set vb t_vb=                                        " 兼容mac去错误操作声音
    set backspace=indent,eol,start                      " 允许退格键的使用
    set whichwrap=b,s,<,>,[,]                           " 左右光标移动到头时可以自动下移
    set list                                            " 设置显示不可见标示符
    set listchars=tab:›\ ,trail:•,extends:#,nbsp:.      " 设置tab用>   ,空格用•等标识符号
    set completeopt=longest,menu                        " 关掉智能补全时的预览窗口
    set ignorecase                                      " 搜索时忽略大小写
    set shiftwidth=4                                    " 第一行设置tab键为4个空格，第二行设置当行之间交错时使用4个空格
    set tabstop=4                                       " 让一个tab等于4个空格 
    set softtabstop=4                                   " 使用4个空格来代替tab 简写 set sts=4
    set expandtab                                       " 将插入状态下的tab 更改为空格
    set ffs=unix,dos                                    " 设置预览模式为unix or dos(windows)
    set ff=unix                                         " 设置写入模式为unix



" }

" Use Plugin config {
    if filereadable(expand("~/.vimrc.plugin"))
        source ~/.vimrc.plugin
    endif
" }

" Use default Quick Start config {
    if filereadable(expand("~/.vimrc.quickstart"))
        source ~/.vimrc.quickstart
    endif
" }

" Use local config {
    if filereadable(expand("~/.vimrc.local"))
        source ~/.vimrc.local
    endif
" }

nmap <F3> :tabprevious<cr>
nmap <F4> :tabnext<cr>
"--------------------------------状态栏设置--------------------------------
" 开启状态栏菜单
set wildmenu

"总是显示状态栏status line
set laststatus=2

highlight StatusLine cterm=bold ctermfg=yellow ctermbg=blue

function! CurDir()
    let curdir = substitute(getcwd(), $HOME, "~", "g")
    return curdir
endfunction

set statusline=[%n]\ %f%m%r%h\ \|\ \ CWD:\ %{CurDir()}/\ %=\|\ %l,%c\ %p%%\ \|\ ascii=%b%{((&fenc==\"\")?\"\":\"\ \|\ \".&fenc)}\ \|\ %{$USER}\ @\ %{hostname()}\
