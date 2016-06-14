
function prompt_command() {
    if [[ $VIRTUAL_ENV != "" ]]; then
        venv="${red}(${VIRTUAL_ENV##*/})"
    else
        venv=""
    fi

    if [ -d .git ]; then
        local branch="$(git rev-parse --abbrev-ref HEAD)"
        PS1="${venv}${cyan}\W${green} (${branch})${normal}\$ "
    else
        PS1="${venv}${cyan}\W${normal}\$ "
    fi
}

PROMPT_COMMAND=prompt_command;
