
function prompt_command() {
    if [[ $VIRTUAL_ENV != "" ]]; then
        venv="${red}(${VIRTUAL_ENV##*/})"
    else
        venv=""
    fi

    if [ -d .git ]; then
        local branch="$(git symbolic-ref --short HEAD)"
        PS1="${venv}${cyan}\W${green} (${branch})${normal}\$ "
    else
        PS1="${venv}${cyan}\W${normal}\$ "
    fi
}

PROMPT_COMMAND=prompt_command;
