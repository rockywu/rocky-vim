#!/usr/bin/env bash
endpath="$HOME/.rocky-vim"

msg() {
    printf '%b\n' "$1" >&2
}
result(){
    if [ "$?" -eq '0' ]; then
        msg "\e[32m[✔]\e[0m ${1}${2}"
    else
        msg "\e[31m[✘]\e[0m ${1}${2}"
    fi
}
error() {
    msg "\e[31m[✘]\e[0m ${1}${2}"
    exit 0
}
if [ ! -e "$HOME/.vimrc.link.backup" ] && [ ! -d "$HOME/.vim.link.backup" ]; then
    error "don't repair"
fi
if [ -e "$HOME/.vimrc.link.backup" ]; then
    str="mv \"$HOME/.vimrc.link.backup\" \"$HOME/.vimrc\""
    eval $str
    result $str
fi
if [ -d "$HOME/.vim.link.backup" ]; then
    rm -rf "$HOME/.vim"
    str="mv \"$HOME/.vim.link.backup\" \"$HOME/.vim\""
    eval $str
    result $str
fi
if [ -e "$HOME/.vimrc.bundles" ]; then
    str="rm \"$HOME/.vimrc.bundles\""
    eval $str
    result $str
fi
if [ -e "$HOME/.vimrc.before" ]; then
    str="rm \"$HOME/.vimrc.before\""
    eval $str
    result $str
fi
if [ -e "$HOME/.vimrc.plugin" ]; then
    str="rm \"$HOME/.vimrc.plugin\""
    eval $str
    result $str
fi
#rm -rf $endpath
