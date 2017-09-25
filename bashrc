#!/usr/bin/env bash

# Load virtualenvwrapper
source /usr/local/bin/virtualenvwrapper.sh

# Context-specific commands
source ~/.bash_it_rc
source ~/.shiftgig_rc

# Configure bash history
# - make it really big
# - if the current line matches previous lines, remove them
# - ignore lines prefixed with an empty space (useful with sensitive data)
unset HISTFILESIZE
export HISTFILESIZE=999999999
export HISTCONTROL=ignoreboth:erasedups

# custom aliases
alias ...="cd ../.."
alias please='sudo $(history -p \!\!)'
alias clean_pyc='\rm $(find . -name "*.pyc")'
alias rm="trash-put"
alias findfile="find . -name"
alias rmswp='\rm $(findfile ".*.swp")'

# custom functions
make_python_dir() {
    for dir in "$@"
    do
        mkdir -p $dir
        current_directory=''
        while IFS='/' read -ra NEWPATH; do
            for index in ${!NEWPATH[@]}; do
                current_directory=$current_directory${NEWPATH[$index]}/
                touch "$current_directory"__init__.py
            done
        done <<< "$dir"
    done
}
alias mkpydir=make_python_dir

# for pip install errors on osx
export CFLAGS=-Qunused-arguments
export CPPFLAGS=-Qunused-arguments

# Local additions or overrides
source ~/.extra_rc 2> /dev/null
