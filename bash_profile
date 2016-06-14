#!/usr/bin/env bash

## Load virtualenvwrapper
source /usr/local/bin/virtualenvwrapper.sh

## Context-specific commands
source ~/.bash_it_rc
source ~/.shiftgig_rc

## Custom stuff
# modify shell colors
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export PATH=$PATH:/usr/local/bin:/usr/local/sbin
alias rm="trash-put $1"

# custom aliases
alias ...="cd ../.."
alias please='sudo $(history -p \!\!)'
alias clean_pyc='\rm $(find . -name "*.pyc")'

# for pip install errors on osx
export CFLAGS=-Qunused-arguments
export CPPFLAGS=-Qunused-arguments
