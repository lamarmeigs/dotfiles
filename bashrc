#!/usr/bin/env bash

# Load virtualenvwrapper
source ~/.local/bin/virtualenvwrapper.sh

# Load pyenv, if necessary
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

# Context-specific commands
source ~/.bash_it_rc
source ~/.shiftgig_rc 2>/dev/null
source ~/.divvydose_rc 2>/dev/null

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
alias rmpyc='find . -name "*.pyc" -delete && find . -name "__pycache__" -type d -delete'
alias rmswp='\rm $(findfile ".*.swp")'
alias rm="trash-put"
alias findfile="find . -name"
alias docker-stop-all='docker stop $(docker ps -aq)'
alias docker-rm-all='docker rm $(docker ps -aq)'

# custom functions
edit_files_with_pattern() {
    vim $(grep $@ -rl --exclude *.pyc)
}
alias vgrep=edit_files_with_pattern

remove_empty_directories() {
    # Remove all empty directories at the specified paths
    for dir in "$@"
    do
        find $dir -empty -type d -delete
    done
}
alias rmedir=remove_empty_directories

make_python_dir() {
    # recursively create directories with a placeholder __init__.py file
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

gourcerer() {
    # Generate videos visualizing git commit history (requires gource & ffmpeg)
    #
    # Usage:
    # $> gourcerer /path/to/config
    #
    # Config format
    # /path/to/repo screen-resolution seconds-per-day frame-rate hidden_fields
    # ~/projects/test_repo 1280x720 1 60 bloom

    mkdir -p ~/screensavers /tmp/gourcerer
    while IFS=$' ' read -r repo_path resolution secs_per_day frame_rate hidden; do

        # Check out the latest version of the main branch
        pushd $repo_path >/dev/null
        repo_name=`basename $(git rev-parse --show-toplevel)`
        git_source=`git remote get-url origin`
        git clone $git_source /tmp/gourcerer/$repo_name

        # Generate git history video
        pushd /tmp/gourcerer/$repo_name >/dev/null
        gource -$resolution -s $secs_per_day --file-idle-time 0 --key --title $repo_name --hide mouse,$hidden -r $frame_rate -o $repo_name.ppm &&
            ffmpeg -y -r $frame_rate -f image2pipe -vcodec ppm -i $repo_name.ppm -vcodec libx264 -preset ultrafast -pix_fmt yuv420p -crf 1 -bf 0 ~/screensavers/$repo_name.mp4 </dev/null

        # Clean up
        \rm -f $repo_name.ppm
        popd >/dev/null
        \rm -rf /tmp/gourcerer/$repo_name
        popd >/dev/null
    done < $1
    \rm -rf /tmp/gourcerer
}



# for pip install errors on osx
export CFLAGS=-Qunused-arguments
export CPPFLAGS=-Qunused-arguments

# Local additions or overrides
source ~/.extra_rc 2> /dev/null

# Load NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Load Poetry
export PATH="$HOME/.poetry/bin:$PATH"


# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /Users/lamar/.nvm/versions/node/v8.11.4/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash ] && . /Users/lamar/.nvm/versions/node/v8.11.4/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /Users/lamar/.nvm/versions/node/v8.11.4/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash ] && . /Users/lamar/.nvm/versions/node/v8.11.4/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash

# Load Yarn
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
