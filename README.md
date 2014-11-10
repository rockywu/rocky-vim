rocky-vim
=========

添加自动化vim IDE 使用 bundle进行管理

### 安装

    $: /bin/bash ./bootstrap.sh 

### 卸载

    $: /bin/bash ./uninstall.sh

### 快捷键
    
* 光标快速移动
        
        /* 按照字母标识移动 */
        ,,w         按文档顺序向下移动到单词位置。
        ,h          向前移动到某单词位置。
        ,j          向下移动某行位置。
        ,k          向上移动到某行位置。
        ,l          向后移动到某个单词位置。
        s           在normal状态下按s，在按任意字符，可以移动到你指定的字母位置。

        /* nerdtree 快捷键*/
        <C-e>       打开文件列表
        ,nt         打开当前文件所在的目录树

         /* 文件快速查找 */
        <C-p>       按照字符串自动匹配文件
                <C-k>   上移
                <C-j>   下移
                <C-t>   新凯tab打开文件
                回车键  当前tab打开文件

        /* tab快速切换 */
        <C-h>       前一个tab
        <C-l>       后一个tab
        <C-j>       前一个打开的文件
        <C-k>       后一个打开的文件


