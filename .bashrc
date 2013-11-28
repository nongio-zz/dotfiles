# homebrew executable priority
export PATH=/usr/local/bin:$PATH

# npm development bin folder, be carefull...
export PATH="./node_modules/.bin:$PATH"

# rvm to PATH for scripting
PATH=$PATH:$HOME/.rvm/bin 
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# heroku toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

#bash completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

#nvm
. ~/.nvm/nvm.sh

#powerline shell!!!
function _update_ps1() {
    export PS1="$(~/powerline-shell.py $? 2> /dev/null)"
}

export PROMPT_COMMAND="_update_ps1"
