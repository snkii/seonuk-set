### 운영체제 감지 ###
OS_TYPE="$(uname)"


### Homebrew ###
if [ "$(uname)" = "Darwin" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi


### Miniconda (OS-aware) ###
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!

if [ "$OS_TYPE" = "Darwin" ]; then
    # macOS의 경우
    CONDA_ROOT="/opt/homebrew/Caskroom/miniconda/base"
else
    # 리눅스의 경우 (기본값)
    CONDA_ROOT="$HOME/miniconda3"
fi

# conda 초기화 로직
__conda_setup="$("$CONDA_ROOT/bin/conda" 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$CONDA_ROOT/etc/profile.d/conda.sh" ]; then
        . "$CONDA_ROOT/etc/profile.d/conda.sh"
    else
        export PATH="$CONDA_ROOT/bin:$PATH"
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

