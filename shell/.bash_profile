#!/usr/bin/env bash

# bash completion
if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

# git prompt
if [ -f `brew --prefix`/opt/bash-git-prompt/share/gitprompt.sh ]; then
  __GIT_PROMPT_DIR=$(brew --prefix)/opt/bash-git-prompt/share
fi

# docker version manager
[ -f /usr/local/opt/dvm/dvm.sh ] && . /usr/local/opt/dvm/dvm.sh
[[ -r $DVM_DIR/bash_completion ]] && . $DVM_DIR/bash_completion

# kubectl auto-completion
source ~/.kubectl-completion

# go environment variables
export GOPATH=$HOME/golang
export PATH=$PATH:$GOPATH/bin

# path for python
export PATH=/usr/local/opt/python/libexec/bin:$PATH

# path for rust
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.cargo/bin/racer:$PATH"


# Load the shell dotfiles
DOTFILE="${HOME}/github/thibault/dotfiles"

load_files() {
    declare -a files=(
        $DOTFILE/shell/aliases
        $DOTFILE/shell/exports
        $DOTFILE/shell/functions
        $DOTFILE/shell/options
        $DOTFILE/shell/prompt

        # exta help specific to work
        ~/Google Drive/Work/extra
    )

    # if these files are readable, source them
    for index in ${!files[*]}
    do
        if [[ -r ${files[$index]} ]]; then
            source ${files[$index]}
        fi
    done
}

load_files

# FZF config
export FZF_COMPLETION_TRIGGER='~~'
export FZF_COMPLETION_OPTS='+c -x'
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export PATH="/usr/local/sbin:$PATH"
