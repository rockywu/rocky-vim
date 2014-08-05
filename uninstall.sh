#!/usr/bin/env bash
endpath="$HOME/.rocky-vim"
vimrcbak="$HOME/.vimrc.backup"

msg() {
    printf '%b\n' "$1" >&2
}

success() {
    msg "\e[32m[✔]\e[0m ${1}${2}"
}
error() {
    msg "\e[31m[✘]\e[0m ${1}${2}"
    exit 0
}
if [ ! -e "$HOME/.vimrc.link.backup" ] && [ ! -d "$HOME/.vim.link.backup" ]; then
    error "don't run backup"
fi
if [ -e "$HOME/.vimrc.link.backup" ]; then
    str="mv \"$HOME/.vimrc.link.backup\" \"$HOME/.vimrc\""
    eval $str
    success $str
fi
if [ -d "$HOME/.vim.link.backup" ]; then
    rm -rf "$HOME/.vim"
    str="mv \"$HOME/.vim.link.backup\" \"$HOME/.vim\""
    eval $str
    success $str
fi
if [ -e "$HOME/.vimrc.bundles" ]; then
    str="rm \"$HOME/.vimrc.bundles\""
    eval $str
    success $str
fi

#rm -rf $endpath
