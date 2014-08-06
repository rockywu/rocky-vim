" Use bundles config {
if filereadable(expand("~/.vimrc.bundles"))
	source ~/.vimrc.bundles
endif
" }

"添加基本配置 {
runtime! debian.vim

if has("syntax")
  syntax on
endif

if has("autocmd")
    autocmd FileType text setlocal textwidth=78
endif

"--------------------------------基本设置--------------------------------
"不要vim模仿vi模式，建议设置，否则会有很多不兼容的问题 
set nocompatible

"set mouse=a

"Set mapleader
let mapleader = ","
let g:mapleader = ","
let g:snips_author="rockywu 吴佳雷"

"高亮显示结果
set hlsearch

"show matching bracets
set showmatch
 
"在输入要搜索的文字时，vim会实时匹配 
set incsearch

" vim 会话操作 -- 使CTRL-Z 可以挂起vim  使用fg 可以回到之前挂起vim的位置 Session options
set sessionoptions-=curdir
set sessionoptions+=sesdir

"关闭文件备份
set nobackup
set nowb

"取消使用SWP文件缓冲
set noswapfile

"当vim进行编辑时，如果命令错误，会发出一个响声，该设置去掉响声
set noerrorbells
set vb t_vb=

"允许退格键的使用 
set backspace=indent,eol,start

"左右光标移动到头时可以自动下移
set whichwrap=b,s,<,>,[,]

"将一个tab设置为>-格式,用$结尾
"set listchars=tab:>-,eol:$
"set listchars=tab:>-
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.

" Command <Tab> completion, list matches, then longest common part, then all.
set wildmode=list:longest,full

"vim使用自动对起，也就是把当前行的对起格式应用到下一行；
set autoindent

"依据上面的对起格式，智能的选择对起方式，对于类似C语言编
set smartindent

"显示不可见字符
set list

"显示行号
set number 

"设置自动换行字符长度
set textwidth=180

"设置折行
"set nowrap "不自动折行
set nowrap "自动折行 

"*自动设置目录为正在编辑的文件所在目录*
"set autochdir

"Set to auto read when a file is changed from the outside
set autoread

" 开启拼写建议
"set spell

" 关掉智能补全时的预览窗口
set completeopt=longest,menu

let g:vimrc_loaded = 1

" 预设文件模式为unix 但如果是dos文件
set ffs=unix,dos
set ff=unix

"--------------------------------------------------------------------------


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

"--------------------------------------------------------------------------

"------------------------user interface 基本配置-------------------------
"Always show current position
set ruler

" 设置 命令行行高为2行
set cmdheight=2


" 搜索时忽略大小写
set ignorecase

"开启魔术功能 此功能可以在 :help magic中查看，蛮有用的
set magic

"--------------------------------------------------------------------------


"--------------------------------Tab按钮设置-------------------------------
"第一行设置tab键为4个空格，第二行设置当行之间交错时使用4个空格
set shiftwidth=4

"让一个tab等于4个空格 
set tabstop=4  

" 使用4个空格来代替tab 简写 set sts=4
set softtabstop=4 

" 将插入状态下的tab 更改为空格 简写 set et
set expandtab


" }

" 快捷键 {
"--------------------------------快速键设置--------------------------------
"Fast reloading of the _vimrc
map <silent> <leader>ss :source ~/.vim/_vimrc<cr>

"Fast editing of _vimrc
" map <silent> <leader>ee :call SwitchToBuf("~/.vim/_vimrc")<cr>

"实现CTRL-S保存操作
nmap <c-s> :w<CR>
imap <c-s> <Esc>:w<CR>a

"快速保存快捷键
nmap <silent> <leader>ww :w<cr>
nmap <silent> <leader>wf :w!<cr>

"快速退出快捷键
nmap <silent> <leader>qw :wq<cr>
nmap <silent> <leader>qf :q!<cr>
nmap <silent> <leader>qq :q<cr>
nmap <silent> <leader>qa :qa<cr>
"快速切换窗口
nmap <C-w> <C-w><C-w>

"Tab configuration
map <leader>tn :tabnew
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
nmap <silent> <leader>bp :tabprevious<cr>
nmap <silent> <leader>bn :tabnext<cr>
nmap <F3> :tabprevious<cr>
nmap <F4> :tabnext<cr>
"创建草稿文件
map <leader>es :tabnew<cr>:setl buftype=nofile<cr>
"创建临时文件
map <leader>ec :tabnew ~/tmp/scratch.txt<cr>

"使用 *,#搜索当前选择的内容
" vnoremap <silent> * :call VisualSearch('f')<CR>
" vnoremap <silent> # :call VisualSearch('b')<CR>

" 删除行尾空格并且保存该文件
" nmap <silent> <leader>ws :call DeleteTrailingWS()<cr>:w<cr>

" 设置自动完成快捷键 设置
set completeopt=menu
set complete-=u
set complete-=i
inoremap <C-]>             <C-X><C-]>
inoremap <C-F>             <C-X><C-F>
inoremap <C-D>             <C-X><C-D>
inoremap <C-L>             <C-X><C-L>

" }
