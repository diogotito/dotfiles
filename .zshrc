# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
ZSH=/usr/share/oh-my-zsh/

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME=powerline
# ZSH_THEME=frisk
# ZSH_THEME=agnoster
# ZSH_THEME=af-magic

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"
export HISTSIZE=100000
export HISTFILESIZE=100000
export HISTFILE=~/.zsh_history

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(git)
plugins=(git fzf zsh-abbr)


# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

source $ZSH/oh-my-zsh.sh

# autoload -Uz promptinit
# promptinit
# prompt adam1

autoload -U select-word-style
select-word-style bash

function rr() {
    ranger --choosedir=$HOME/.rangerdir "$@"
    cd "$(cat ~/.rangerdir)"
    rm ~/.rangerdir
}

unalias run-help
function run-help() {
    if ! man "$@"; then
        $1 --help || $1 -h
    fi
}

export TERMINAL="xfce4-terminal"
export EDITOR="vim"
export VISUAL=$EDITOR

source ~/.aliases

# fasd
eval "$(fasd --init auto)"
bindkey '^X^A' fasd-complete
bindkey '^X^F' fasd-complete-f
bindkey '^X^Z' fasd-complete-d

bindkey -s '^[m' '^a{^e 2>/dev/null &} && disown\n'
bindkey -s '^[R' 'tput reset\n'
bindkey -s '^[L' 'exa --long -F --git^M'
bindkey -s '^[F' 'thunar .\n'
bindkey -s '\e[18~' 'mkdir '  # Binds F7

# woooooooooooooooooooooooooooooow
bindkey -s '^[r' 'rr\n'
# bindkey -s '^X^P' 'zathura --fork pdf^X^F'
bindkey -s '^X^P' 'open-pdf\nexit\n'

function open-pdf() (
    set -o pipefail

    PDF_READER=(zathura --fork)

    DECOR=("$HOME/Dropbox/" "\ue707 "
           "$HOME"          "~")

    function filter() {
        sed --null-data -E "\;$HOME/\.\w+;d"
    }

    function decorate() {
        sed --null-data -E "$(for path icon in $DECOR; do printf "s;$path;$icon;\n"; done)"
    }

    function undecorate() {
        sed --null-data -E "$(for path icon in $DECOR; do printf "s;$icon;$path;\n"; done)"
    }

    [[ $1 == -u ]] && dunstify decorating "$2" && sleep 2s && res="$(undecorate <<<"$2")" && dunstify result: "$res" && echo yay && sleep 10s
    PREVIEW='pdftotext "$(zsh -ic '\''open-pdf -u "{}"'\'')" -'

    exec locate --null --existing "$HOME/*.pdf" \
        | filter \
        | decorate \
        | fzf --read0 --multi --reverse --print0 \
        | undecorate \
        | xargs --null --no-run-if-empty $PDF_READER
                                                                   # --preview="$PREVIEW" 
)

# nnoremap <C-p> :vertical rightbelow terminal ++close zsh -c "source ~/.zshrc && open-pdf"<CR>

if [[ $LAUNCH = yes ]]; then
    cat <<EOF
Some shortcuts:
  * Ctrl+X, Ctrl+p -> view a "frecent" pdf

EOF
    bindkey -s '^M' '&\ndisown\nexit\n'
    bindkey -s '^X^P' 'zathura --fork "$(locate "$HOME/*.pdf" | fzf -m)"\nexit\n'
fi

# Exercism completions
if [ -f ~/.config/exercism/exercism_completion.zsh ]; then
    . ~/.config/exercism/exercism_completion.zsh 
fi

# Powerline
F=/usr/lib/python3.7/site-packages/powerline/bindings/zsh/powerline.zsh
powerline-daemon -q
[ -f $F ] && . $F

# Ruby gems
if which ruby >/dev/null && which gem >/dev/null; then
        PATH="$(ruby -r rubygems -e 'puts Gem.user_dir')/bin:$PATH"
fi

# VTE Configuration for Tilix
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi

# # Emscripten
#
# if [ -f ~/asdf/emsdk/emsdk_env.sh ]; then
#     source ~/asdf/emsdk/emsdk_env.sh
# fi

# Bitwarden
export BW_SESSION="0zAJ8dcK6vJT3UewqnHmjs+xS8Q0QIxeb3K+onCtpIxb/3GPGnrq3WSryAT5gQMO0kQYBlUuQTeOYTbmDe0ryg=="

export PATH=/home/diogo/.local/bin:/home/diogo/.emacs.d/bin:$PATH

source /home/diogo/.config/broot/launcher/bash/br

# Starship
eval "$(starship init zsh)"

