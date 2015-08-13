#!/usr/bin/env bash
############################  TEST CONFIGURE
#set -x

# get execute path
get_execute_path(){
    #bash get current file directory
    local DIR;
    DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    echo "$DIR";
}
############################  SETUP PARAMETERS
app_name='rocky-vim'
[ -z "$git_uri" ] && git_uri='https://github.com/rockywu/rocky-vim.git'
git_branch='master'
today=`date +%Y%m%d_%s`
endpath="$HOME/.$app_name"
debug_mode='0'
executepath=`get_execute_path`
[ -z "$VUNDLE_URI" ] && VUNDLE_URI="https://github.com/gmarik/Vundle.vim.git"

############################  BASIC SETUP TOOLS

go_execute_path() {
    cd $executepath;
}

msg() {
    printf '%b\n' "$1" >&2
}
result(){
    if [ "$ret" -eq '0' ]; then
        msg "\e[32m[✔]\e[0m ${1}${2}"
    else
        msg "\e[31m[✘]\e[0m ${1}${2}"
    fi
}

error() {
    msg "\e[31m[✘]\e[0m ${1}${2}"
    exit 0
}

debug() {
    if [ "$debug_mode" -eq '1' ] && [ "$ret" -gt '1' ]; then
      msg "An error occurred in function \"${FUNCNAME[$i+1]}\" on line ${BASH_LINENO[$i+1]}, we're sorry for that."
    fi
}

program_exists() {
    local ret='0'
    type $1 >/dev/null 2>&1 || { local ret='1'; }

    # throw error on non-zero return value
    if [ ! "$ret" -eq '0' ]; then
    error "$2"
    fi
}

############################ SETUP FUNCTIONS
lnif() {
    if [ -e "$1" ]; then
        ln -sf "$1" "$2"
    fi
    ret="$?"
    result "ln -sf \"$1\" \"$2\""
    debug
}

do_backup() {
    if [ -e "$2" ] || [ -e "$3" ] || [ -e "$4" ]; then
        for i in "$2" "$3" "$4"; do
            if [ -e "$i" ]; then
                linkpath=`readlink $i`
                if [ "$linkpath" == "$endpath" ];then
                    continue 1
                fi
                if [ "$linkpath" == "$endpath/vimrc" ];then
                    continue 1
                fi
                if [ -L "$i" ];then
                    if [ -e "$i.link.backup" ];then
                        mv "$i.link.backup" "$i.$today.link.backup"
                        ret="$?"
                        result "mv \"$i.link.backup\" \"$i.$today.link.backup\""
                        debug
                    fi
                    mv "$i" "$i.link.backup"
                    ret="$?"
                    result "mv \"$i\" \"$i.link.backup\""
                    debug
                else
                    mv "$i" "$i.$today.nolink.backup"
                    ret="$?"
                    result "mv \"$i\" \"$i.$today.nolink.backup\""
                    debug
                fi
            fi
        done
        ret="$?"
        result "$1"
        debug
   fi
}

upgrade_repo() {
      msg "trying to update $1"

      if [ "$1" = "$app_name" ]; then
          cd "$HOME/.$app_name" &&
          git reset --hard &&
          git pull --rebase origin "$git_branch"
      fi

      if [ "$1" = "vundle" ]; then
          cd "$endpath/bundle/Vundle.vim" &&
          git pull --rebase origin master
      fi

      ret="$?"
      result "$2"
      debug
}

clone_repo() {
    program_exists "git" "Sorry, we cannot continue without GIT, please install it first."

    if [ ! -e "$endpath/.git" ]; then
        git clone --recursive -b "$git_branch" "$git_uri" "$endpath"
        ret="$?"
        result "$1"
        debug
    else
        upgrade_repo "$app_name"    "Successfully updated $app_name"
    fi
}

clone_vundle() {
    if [ ! -e "$endpath/bundle/Vundle.vim" ]; then
        git clone $VUNDLE_URI "$endpath/bundle/Vundle.vim"
    else
        upgrade_repo "vundle"   "Successfully updated vundle"
    fi
    ret="$?"
    result "$1"
    debug
}

create_symlinks() {

    if [ ! -d "$endpath/bundle" ]; then
        mkdir -p "$endpath/bundle"
    fi

    lnif "$endpath/vimrc"           "$HOME/.vimrc"
    lnif "$endpath/vimrc.bundles"   "$HOME/.vimrc.bundles"
    lnif "$endpath/vimrc.plugin"    "$HOME/.vimrc.plugin"
    lnif "$endpath/vimrc.shortcut"  "$HOME/.vimrc.shortcut"
    lnif "$endpath/vimrc.local"  "$HOME/.vimrc.local"

    if [ ! -d "$HOME/.vim" ];then
        lnif "$endpath"                 "$HOME/.vim"
    fi

    ret="$?"
    result "$1"
    debug
}

setup_vundle() {
    system_shell="$SHELL"
    export SHELL='/bin/sh'
    if [ -e "$HOME/.vimrc.bundles" ]; then
        vim -u "$HOME/.vimrc.bundles" +BundleInstall! +BundleClean +qall
    else
        error "have not $HOME/.vimrc.bundles"
    fi
    export SHELL="$system_shell"

    result "$1"
    debug
}

############################ MAIN()
program_exists "vim" "To install $app_name you first need to install Vim."

do_backup   "Your old vim stuff has a suffix now and looks like .vim.`date +%Y%m%d%S` or .vim*.link.backup" \
        "$HOME/.vim" \
        "$HOME/.vimrc" \
        "$HOME/.gvimrc"

clone_repo      "Successfully cloned $app_name"

create_symlinks "Setting up vim symlinks"

clone_vundle    "Successfully cloned vundle"

setup_vundle    "Now updating/installing plugins using Vundle"

go_execute_path     "Go back execute path"

msg             "\nThanks for installing $app_name."
msg             "© `date +%Y` https://github.com/rockywu/rocky-vim"
