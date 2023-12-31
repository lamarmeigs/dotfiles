# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"

# Ctrl-u clears the line up to the cursor
bindkey -e
bindkey \^U backward-kill-line

# Ensure AWS_PROFILE envvar is respected by all tools
export AWS_SDK_LOAD_CONFIG=true

# Simplify AWS SSO login
aws_login() {
    export AWS_PROFILE=$1
    aws sts get-caller-identity >/dev/null 2>&1 || aws sso login
}
aws_logout() {
    aws sso logout
    unset AWS_PROFILE
}

# Enable nvm (node version manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Enable pyenv & virtualwrapper
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
pyenv virtualenvwrapper

# Don't use less for paging unnecessarily
export LESS="-F -X -R"

# Build docker containers for the platform on which they'll run
export DOCKER_DEFAULT_PLATFORM=linux/amd64

# Remove all empty directories from the current path
remove_empty_directories() {
    for dir in "$@"
    do
        find $dir -empty -type d -delete
    done
}
alias rmedir=remove_empty_directories

# Create directories with a placeholder __init__.py file
make_python_dir() {
    for dir in "$@"
    do
        mkdir -p $dir
        current_directory='.'
        for directory in ${(s:/:)dir}; do
            current_directory="$current_directory/$directory"
            touch "$current_directory/__init__.py"
        done
    done
}
alias mkpydir=make_python_dir

# GCP
# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi
