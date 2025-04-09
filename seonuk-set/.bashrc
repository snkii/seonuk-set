# ~/.bashrc
### 운영체제 감지 ###
OS_TYPE="$(uname)"


### Homebrew ###
if [ "$(uname)" = "Darwin" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi


### Miniconda (OS-aware) ###
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/sukim/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/sukim/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/sukim/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/sukim/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


### PS1 ###
export PS1="\[\e[1;32m\]\u\[\e[0m\] at \[\e[1;34m\]\h\[\e[0m\]\$(if [ -n \"\$CONDA_DEFAULT_ENV\" ]; then echo \" in \[\e[1;38;5;208m\]\$CONDA_DEFAULT_ENV\[\e[0m\]\"; fi) \[\e[1;33m\]\w\[\e[0m\]\$ "


### Disable zsh warning ###
export BASH_SILENCE_DEPRECATION_WARNING=1


### 환경변수 설정 ###
export CUDA_VISIBLE_DEVICES="0,1,2,3"
export PATH=~/.local/bin:$PATH
export TMPDIR=$HOME/tmp
export PYTHONPATH=/home/sukim/project/icefall-250113/icefall:$PYTHONPATH


### HIL GPU server ###
alias hil='ssh -p 7777 sukim@hi20.snu.ac.kr'


### alias ###
alias ls='ls -A'
alias refresh='source ~/.bashrc'
alias tmux="TERM=xterm-256color tmux"


### virtual env auto activate ###
# conda 환경 자동 활성화/비활성화 (상위 디렉토리 탐색 포함)
function cd() {
    # 현재 디렉토리 저장
    local prev_dir="$PWD"
    local prev_env_file
    local new_env_file
    local prev_env=""
    local new_env=""

    # cd 동작
    builtin cd "$@" || return

    # 상위 디렉토리에서 .conda_auto 탐색 함수
    find_conda_auto_file() {
        local dir="$1"
        while [[ "$dir" != "/" ]]; do
            if [[ -f "$dir/.conda_auto" ]]; then
                echo "$dir/.conda_auto"
                return
            fi
            dir=$(dirname "$dir")
        done
    }

    # 이전 경로에서의 conda 환경 확인
    prev_env_file=$(find_conda_auto_file "$prev_dir")
    if [[ -n "$prev_env_file" ]]; then
        prev_env=$(<"$prev_env_file")
    fi

    # 현재 경로에서의 conda 환경 확인
    new_env_file=$(find_conda_auto_file "$PWD")
    if [[ -n "$new_env_file" ]]; then
        new_env=$(<"$new_env_file")
    fi

    # 환경이 바뀌었으면 deactivate → activate 순서로 적용
    if [[ "$prev_env" != "$new_env" ]]; then
        if [[ -n "$prev_env" ]]; then
            conda deactivate
        fi
        if [[ -n "$new_env" ]]; then
            conda activate "$new_env"
        fi
    fi
}

# CUDA
export CUDA_HOME=/usr/local/cuda-12.1.0
export PATH=$CUDA_HOME/bin:$PATH
export LD_LIBRARY_PATH=$CUDA_HOME/lib64:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$CUDA_HOME/lib:$LD_LIBRARY_PATH

export CUDA_TOOLKIT_ROOT_DIR=$CUDA_HOME
export CUDA_TOOLKIT_ROOT=$CUDA_HOME
export CUDA_BIN_PATH=$CUDA_HOME
export CUDA_PATH=$CUDA_HOME
export CUDA_INC_PATH=$CUDA_HOME/targets/x86_64-linux
export CFLAGS=-I$CUDA_HOME/targets/x86_64-linux/include:$CFLAGS

# icefall
export PYTHONPATH=/home/sukim/project/cuda-12.1/icefall:$PYTHONPATH

# Segmentation fault (core dump) error
export PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=python


[ -f ~/.fzf.bash ] && source ~/.fzf.bash

. "$HOME/.local/bin/env"
