silent function! OSX()
    return has('macunix')
endfunction
silent function! LINUX()
    return has('unix')
endfunction
" Use bundles config {{
    if filereadable(expand("~/.vimrc.bundles"))
        source ~/.vimrc.bundles
    endif
" }}
" 全局变量设定 {{
    let mapleader = ","                                 " 定义快捷按钮
    let g:mapleader = ","                               " 定义全局快捷按钮
    let g:snips_author="rockywu 吴佳雷"                 " 定义作者信息
" }}
" 基本参数配置 {{
    set nocompatible                                    " 关闭vim模仿vi模式
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
    set encoding=utf-8                                  " 设置输入编码为utf-8
    set fileencoding=uft-8                              " 设置保存文件的编码 utf-8
    set fileencodings=utf-8,gbk,gb2312,ucs-bom,latin-1,cp936,gb18030,utf-16,big5    " 设置文件编码检测类型及支持格式
    filetype plugin indent on                           " 自动进行文件类型检测功能（可以自动使用插件进行）
    syntax enable                                       " 设置语法高亮 Highlight进行设置。
    syntax on                                           " 阻止vim 用缺少值覆盖自定义的高亮设置
    set autoread                                        " 文件在Vim之外修改过，自动重新读入
    set foldmethod=syntax                               " 用语法高亮来定义折叠(还有很多模式可以查询google)
    scriptencoding utf-8                                " 设置脚本编码
    set history=1000                                    " history文件中需要记录的行数
    set shortmess+=atI                                  " 启动的时候不显示那个援助索马里儿童的提示
    set hidden                                          " 允许缓存区切换时不保存
    set viewoptions=folds,options,cursor,unix,slash     " Better Unix / Windows compatibility
    set iskeyword+=_,#,-,$                              " 设置以下字符部分被当做单词分割，使用-=_,#,-,$可以除去
    set wildmenu                                        " 开启状态栏菜单
    set wildmode=list:longest,full                      " tab显示菜单栏和命令栏
    set laststatus=2                                    " 总是显示状态栏status line
    set scrolloff=10                                    " 设置光标于顶部最大行数间距
    set cursorline                                      " 高亮显示光标当前所在行
" }}

" 基本UI 配置 {{
    set showmode                                        " 显示 --INSERT-- 之类的字眼在左下角的状态栏
    set backup                                          " 开启编辑文件backup
    if has('persistent_undo')
        set undofile                                    " 开启持久撤销 So is persistent undo ...
        set undolevels=1000                             " Maximum number of changes that can be undone
        set undoreload=10000                            " Maximum number lines to save for undo on a buffer reload
    endif

    " Initialize directories {
        function! InitializeDirectories()
            let parent = $HOME
            let prefix = 'vim'
            let dir_list = {
                        \ 'backup': 'backupdir',
                        \ 'views': 'viewdir',
                        \ 'swap': 'directory' }

            if has('persistent_undo')
                let dir_list['undo'] = 'undodir'
            endif

            let common_dir = parent . '/.' . prefix

            for [dirname, settingname] in items(dir_list)
                let directory = common_dir . dirname . '/'
                if exists("*mkdir")
                    if !isdirectory(directory)
                        call mkdir(directory)
                    endif
                endif
                if !isdirectory(directory)
                    echo "Warning: Unable to create backup directory: " . directory
                    echo "Try: mkdir -p " . directory
                else
                    let directory = substitute(directory, " ", "\\\\ ", "g")
                    exec "set " . settingname . "=" . directory
                endif
            endfor
        endfunction
        call InitializeDirectories()            " 创建备份目录和swap目录（.swap&~)
    " }

" }}

" Use Plugin config {
    if filereadable(expand("~/.vimrc.plugin"))
        source ~/.vimrc.plugin
    endif
" }

" Use default Shortcut config {
    if filereadable(expand("~/.vimrc.shortcut"))
        source ~/.vimrc.shortcut
    endif
" }

" Use local config {
    if filereadable(expand("~/.vimrc.local"))
        source ~/.vimrc.local
    endif
" }

" 默认状态栏 {{
if !isdirectory(expand("~/.vim/bundle/vim-airline/"))
    highlight StatusLine cterm=bold ctermfg=yellow ctermbg=blue

    function! CurDir()
        let curdir = substitute(getcwd(), $HOME, "~", "g")
        return curdir
    endfunction

    set statusline=[%n]\ %f%m%r%h\ \|\ \ CWD:\ %{CurDir()}/\ %=\|\ %l,%c\ %p%%\ \|\ ascii=%b%{((&fenc==\"\")?\"\":\"\ \|\ \".&fenc)}\ \|\ %{$USER}\ @\ %{hostname()}\
endif
" }}

