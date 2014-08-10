#!/bin/bash
# get bash path
function get_base_path(){
    #bash get current file directory
    local DIR;
    DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    echo "$DIR";
}

PRJ_TYPE=php
case ${PRJ_TYPE} in
    php)
    SRC_DIR='.'
    echo $SRC_DIR;
    find ${SRC_DIR}             \
        -name ".git" -prune     \
        -or -name "*.php"       \
        -or -name "*.js"        \
        -or -name "*.phtml"     \
        -or -name "*.css"       \
        -or -name "*.html"      \
        -or -name "*.sh"        \
        -type f                 \
        > cscope.files
    ;;
    *)
    ;;
esac

cscope -bkq -i cscope.files
/usr/local/bin/ctags -L cscope.files
