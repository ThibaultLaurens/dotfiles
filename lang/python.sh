#!/bin/bash

echo "installing python..."

# prepare the python build environment
if [[ $(uname) == "Darwin" ]]; then
    brew install openssl readline sqlite3 xz zlib
elif [[ $(uname) == "Linux" ]]; then
    sudo apt update
    sudo apt install --no-install-recommends \
         make build-essential libssl-dev zlib1g-dev libbz2-dev \
         libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev \
         xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
fi

# install pyenv
: "${PYENV_ROOT:=$HOME/.pyenv}"
if [ ! -d "$PYENV_ROOT" ]; then
    if [[ $(uname) == "Darwin" ]]; then
        brew install pyenv
    elif [[ $(uname) == "Linux" ]]; then
        curl https://pyenv.run | bash
    fi
fi

PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

pyenv install 3.7.7
pyenv global 3.7.7

echo "installing python packages..."

packages=(
    'autoflake'                   # removes unused imports and unused variables
    'black'                       # code formatter
    'epc'                         # RPC stack for Emacs Lisp
    'flake8'                      # style guide enforcement
    'importmagic'                 # find unresolved imports
    'ipython[all]'                # interactive python
    'isort'                       # sort imports
    'mypy'                        # optional static typing checker
    'pip'                         # package installer
    'setuptools'                  # build and distribute packages
    'virtualenv'                  # create isolated python environments
    'virtualenvwrapper'           # extensions for virtualenv
    'yamllint'                    # linter for YAML files
)

pip install --upgrade "${packages[@]}"
