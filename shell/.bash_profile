#!/bin/bash

# set -euo pipefail

source ~/.bashrc

OS_NAME=$(uname -s)
export OS_NAME

if [ "$OS_NAME" == "Darwin" ]; then
    source "$dot/shell/macos.sh"
elif [ "$OS_NAME" == "Linux" ]; then
    source "$dot/shell/linux.sh"
else
    echo "Unknown operating system."
fi

if [ "$HOSTNAME" == "u60" ]; then
    source "$dot/shell/nvidia.sh"
    export s1=/media/tandav/sg8tb1
    export JAVA_HOME='/usr/lib/jvm/java-8-openjdk-amd64'
fi

source "$dot/shell/git.sh"
source "$dot/private/private.sh"
source "$dot/shell/main.sh"

# The next line updates PATH for Yandex Cloud CLI.
if [ -f "$HOME/yandex-cloud/path.bash.inc" ]; then source "$HOME/yandex-cloud/path.bash.inc"; fi

# The next line enables shell command completion for yc.
if [ -f "$HOME/yandex-cloud/completion.bash.inc" ]; then source "$HOME/yandex-cloud/completion.bash.inc"; fi
