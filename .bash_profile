#!/bin/bash

source ~/.bashrc

# # >>> conda initialize >>>
# # !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/usr/local/Caskroom/miniconda/base/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
#         . "/usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh"
#     else
#         export PATH="/usr/local/Caskroom/miniconda/base/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# # <<< conda initialize <<<

# Setting PATH for Python 3.11
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.11/bin:${PATH}"
export PATH

# The next line updates PATH for Yandex Cloud CLI.
# macos
if [ -f '/Users/tandav/yandex-cloud/path.bash.inc' ]; then source '/Users/tandav/yandex-cloud/path.bash.inc'; fi
# linux
# if [ -f '/home/tandav/yandex-cloud/path.bash.inc' ]; then source '/home/tandav/yandex-cloud/path.bash.inc'; fi

# The next line enables shell command completion for yc.
# macos
if [ -f '/Users/tandav/yandex-cloud/completion.bash.inc' ]; then source '/Users/tandav/yandex-cloud/completion.bash.inc'; fi
# linux
# if [ -f '/home/tandav/yandex-cloud/completion.bash.inc' ]; then source '/home/tandav/yandex-cloud/completion.bash.inc'; fi

# if [ -f "/home/tandav/miniconda3/etc/profile.d/mamba.sh" ]; then
#     . "/home/tandav/miniconda3/etc/profile.d/mamba.sh"
# fi

# . "$HOME/.cargo/env"
