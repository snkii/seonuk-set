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


### Run .bashrc ###
if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi


