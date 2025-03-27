### HIL GPU server ###
alias hil='ssh -p 7777 sukim@hi20.snu.ac.kr'


### alias ###
alias ls='ls -a'
alias refresh='source ~/.bashrc'


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

