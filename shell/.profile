#!/bin/bash

# set -euo pipefail

# =====================================================================================

export EDITOR=micro
export dt=~/Desktop
export dw=~/Downloads
export dot=~/docs/dotfiles
export bh=~/docs/bhairava
export PATH=$dot/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/yandex-cloud/bin:$PATH

# =====================================================================================

OS_NAME=$(uname -s)
export OS_NAME

if [ "$OS_NAME" == "Darwin" ]; then
    export SHELL=/usr/local/bin/bash
    . "$dot/shell/macos.sh"
    . "$dot/private/private.sh"
elif [ "$OS_NAME" == "Linux" ]; then
    export SHELL=/usr/bin/bash
    . "$dot/shell/linux.sh"
else
    echo "Unknown operating system."
fi

if [ "$HOSTNAME" == "u60" ]; then
    . "$dot/shell/nvidia.sh"
    export JAVA_HOME='/usr/lib/jvm/java-8-openjdk-amd64'
fi

# =====================================================================================

if [ "$BASH" ]; then
    . ~/.bashrc
fi
