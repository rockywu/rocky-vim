" Use bundles config {
    if filereadable(expand("~/.vimrc.bundles"))
        source ~/.vimrc.bundles
    endif
" }

"添加基本配置 {
    if has("syntax")
        syntax on                   " Syntax highlighting
    endif
    if has("autocmd")
        autocmd FileType text setlocal textwidth=78
    endif

    filetype plugin indent on   " Automatically detect file types.

    " set mouse=a                 " Automatically enable mouse usage

    set mousehide               " Hide the mouse cursor while typing

    scriptencoding utf-8        " Set charset

    set ruler                   " show the cursor position all the time

    " ##@## 剪贴板还缺少

    set hlsearch                " 高亮显示结果

    set nocompatible            " 不要vim模仿vi模式，建议设置，否则会有很多不兼容的问题 

    let mapleader = ","         " 设置全局快件按钮
    let g:mapleader = ","

    if !exists('g:snips_author') " 设置作者信息
        let g:snips_author="rockywu 吴佳雷"
    endif

    set incsearch               " 在输入要搜索的文字时，vim会实时匹配 

    " vim 会话操作 -- 使CTRL-Z 可以挂起vim  使用fg 可以回到之前挂起vim的位置 Session options
    set sessionoptions-=curdir
    set sessionoptions+=sesdir

    set noerrorbells            " 关闭错误是的提示响声
    set vb t_vb=                " 禁止屏幕闪烁

    set backspace=indent,eol,start " 允许退格键的使用 

    set listchars=tab:›\ ,trail:•,extends:#,nbsp:.  " 设置特殊字符展示

    set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.

    set autoindent              " vim使用自动对起，也就是把当前行的对起格式应用到下一行；

    set smartindent             " 依据上面的对起格式，智能的选择对起方式，对于类似C语言编

    set list                    " 显示不可见字符

    set number                  " 显示行号

    set textwidth=180           " 设置自动换行字符长度

    " 预设文件模式为unix 但如果是dos文件
    set ffs=unix,dos
    set ff=unix

    set shiftwidth=4            " 第一行设置tab键为4个空格，第二行设置当行之间交错时使用4个空格

    set tabstop=4               " 让一个tab等于4个空格 

    set softtabstop=4           " 使用4个空格来代替tab 简写 set sts=4

    set expandtab               " 将插入状态下的tab 更改为空格 简写 set et

    set ignorecase              " 搜索时忽略大小写

    set magic                   " 开启魔术功能 此功能可以在 :help magic中查看，蛮有用的

    set cmdheight=2            " 设置 命令行行高为2行

    " 关闭文件备份
    set nobackup
    set nowb

    "取消使用SWP文件缓冲
    set noswapfile

    "左右光标移动到头时可以自动下移
    set whichwrap=b,s,<,>,[,]

    "设置折行
    set nowrap "不自动折行
    "set wrap "自动折行 

    "*自动设置目录为正在编辑的文件所在目录*
    "set autochdir

    "Set to auto read when a file is changed from the outside
    set autoread

    " 关掉智能补全时的预览窗口
    set completeopt=longest,menu

    let g:vimrc_loaded = 1
" }

" 设置状态栏 {
    set wildmenu            " 开启状态栏菜单

    set laststatus=2        "总是显示状态栏status line

    highlight StatusLine cterm=bold ctermfg=yellow ctermbg=blue

    function! CurDir()
        let curdir = substitute(getcwd(), $HOME, "~", "g")
        return curdir
    endfunction

    set statusline=[%n]\ %f%m%r%h\ \|\ \ CWD:\ %{CurDir()}/\ %=\|\ %l,%c\ %p%%\ \|\ ascii=%b%{((&fenc==\"\")?\"\":\"\ \|\ \".&fenc)}\ \|\ %{$USER}\ @\ %{hostname()}\


" }

" 快捷键设置 {
    " 在新tab中打开file
    function! SwitchToBuf(filename)
        let bufwinnr = bufwinnr(a:filename)
        if bufwinnr != -1
            exec bufwinnr . "wincmd w"
            return
        else
            tabfirst
            let tab = 1
            while tab <= tabpagenr("$")
                let bufwinnr = bufwinnr(a:filename)
                if bufwinnr != -1
                    exec "normal " . tab . "gt"
                    exec bufwinnr . "wincmd w"
                    return
                endif
                tabnext
                let tab = tab + 1
            endwhile
            exec "tabnew " . a:filename
        endif
    endfunction


    " 此方法用于删除文本行尾的空格
    func! DeleteTrailingWS()
      exe "normal mz"
      %s/\s\+$//ge
      nohl
      exe "normal `z"
    endfunc

    " 快速打开本地配置
    map <silent> <leader>ss :source ~/.vimrc.local<cr>

    " 快速编辑本地配置
    map <silent> <leader>ee :call SwitchToBuf("~/.vimrc.local")<cr>

    " 快速保存快捷键
    nmap <silent> <leader>ww :w<cr>
    nmap <silent> <leader>wf :w!<cr>

    " 快速退出快捷键
    nmap <silent> <leader>qw :wq<cr>
    nmap <silent> <leader>qf :q!<cr>
    nmap <silent> <leader>qq :q<cr>
    nmap <silent> <leader>qa :qa<cr>

    " 快速切换窗口
    nmap <C-w> <C-w><C-w>

    " 创建草稿文件
    map <leader>es :tabnew<cr>:setl buftype=nofile<cr>

    " 创建临时文件
    map <leader>ec :tabnew ~/tmp/scratch.txt<cr>

    " 快速切换tab
    nmap <silent> <leader>p :tabprevious<cr>
    nmap <silent> <leader>n :tabnext<cr>
    nmap <F3> :tabprevious<cr>
    nmap <F4> :tabnext<cr>

    " 使用 *,#搜索当前选择的内容
    vnoremap <silent> * :call VisualSearch('f')<CR>
    vnoremap <silent> # :call VisualSearch('b')<CR>

    " 删除行尾空格并且保存该文件
    nmap <silent> <leader>ws :call DeleteTrailingWS()<cr>:w<cr>

" }
