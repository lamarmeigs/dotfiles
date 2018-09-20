#!/usr/bin/env bash

# Load virtualenvwrapper
source /usr/local/bin/virtualenvwrapper.sh

# Load pyenv, if necessary
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

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

        # Generate git history video as background process
        pushd /tmp/gourcerer/$repo_name >/dev/null
        gource -$resolution -s $secs_per_day --file-idle-time 0 --key --title $repo_name --hide mouse,$hidden -r $frame_rate -o $repo_name.ppm &&
            ffmpeg -y -r $frame_rate -f image2pipe -vcodec ppm -i $repo_name.ppm -vcodec libx264 -preset ultrafast -pix_fmt yuv420p -crf 1 -bf 0 ~/screensavers/$repo_name.mp4 </dev/null
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

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /Users/lamarmeigs/.npm-packages/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash ] && . /Users/lamarmeigs/.npm-packages/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /Users/lamarmeigs/.npm-packages/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash ] && . /Users/lamarmeigs/.npm-packages/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash
