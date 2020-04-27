#!/bin/bash

# shellcheck disable=SC1091
source /etc/bash_completion

PATH="/snap/bin:$PATH"

alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

alias free="free -mt"
alias ps="ps auxf"
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"

alias myip="ip -4 addr | grep -oP '(?<=inet\s)\d+(\.\d+){3}'"
alias myip6="ip -6 addr | grep -oP '(?<=inet6\s)[\da-f:]+'"

# load urxvt db and reload it
function urxvt-reload() {
    xrdb ~/.Xresources
    urxvt &
    exit
}

function apt-updater {
	  sudo apt update && \
	  sudo apt full-upgrade -Vy && \
	  sudo apt autoremove -y && \
	  sudo apt autoclean
}


# fix bash_completion on Makefiles
complete -W "\`grep -oE '^[a-zA-Z0-9_.-]+:([^=]|$)' ?akefile | sed 's/[^a-zA-Z0-9_.-]*$//'\`" make