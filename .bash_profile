### Homebrew ###
eval "$(/opt/homebrew/bin/brew shellenv)"


### Miniconda ###
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
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


