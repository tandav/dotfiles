#!/bin/bash

# ===================== python =======================

export PIP_DISABLE_PIP_VERSION_CHECK=1
export PYTHONHISTFILE="$HOME/.cache/.python_history"
export PIP_INDEX_URL=https://pypi.tandav.me/index/

alias req='touch requirements.txt'
alias pip='$HOME/.cache/virtualenvs/uv/bin/uv pip'
alias uv='$HOME/.cache/virtualenvs/uv/bin/uv'

# https://docs.jupyter.org/en/latest/use/jupyter-directories.html#data-files

mkkernel() {
    if [ -n "$1" ]; then
        KERNEL_NAME=$1
    elif [ -n "$VIRTUAL_ENV" ]; then
        KERNEL_NAME="$(basename "$VIRTUAL_ENV")"
        echo "No kernel name provided, using name from virtualenv ($KERNEL_NAME)"
    else
        echo "Pass either kernel name as argument or activate virtualenv"
        return 1
    fi
    python -m pip install ipykernel
    python -m ipykernel install --user --name="$KERNEL_NAME"
}

lskernel() {
    find "$KERNELS_DIR" -mindepth 1 -maxdepth 1 -type d
}

rmkernel() {
    if [ -z "$1" ]; then
        echo "pass kernel name as argument"
        return 1
    fi
    rm -rf "${KERNELS_DIR:?}/$1"
}

pipd() {
    pip install -e .[dev]
}

jh() {
    # open -a $dot/OpenJupyter.app .
    # p $dot/jupyter_opener.py $PWD
    # open "http://localhost:8888/notebooks$(echo $PWD | sed "s|$HOME||")" # https://stackoverflow.com/a/23134318/4204843
    # open "http://localhost:8888/notebooks${PWD#"$HOME"}" # https://stackoverflow.com/a/20615306/4204843
    open "http://localhost:8888/tree${PWD#"$HOME"}" # https://stackoverflow.com/a/20615306/4204843
}

# pyenv
export PYENV_ROOT="$HOME/.cache/pyenv"
command -v pyenv > /dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
