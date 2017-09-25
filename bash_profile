#!/usr/bin/env bash

# Source any system-provided profile
[ -r ~/.profile ] && source ~/.profile

# OS X assumes all terminal session should be login shells
# Source .bashrc explicitly to ensure its contents are applied
source ~/.bashrc

# Include a local bin directory in PATH
export PATH=$PATH:/usr/local/bin:/usr/local/sbin:$HOME/bin

# Modify shell colors
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
