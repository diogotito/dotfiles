#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Convenience options
shopt -s globstar; shopt -s dotglob; shopt -s extglob
shopt -s autocd
shopt -s cdspell; shopt -s dirspell
shopt -s hostcomplete

# History
export HISTSIZE=1000000
export HISTFILESIZE=${HISTSIZE}
export HISTCONTROL=ignoreboth
shopt -s histappend

# ---------------------------------------------------------
# ★ ★ ★ ★ ★  Bookmarks ★ ★ ★ ★ ★
# ---------------------------------------------------------
shopt -s cdable_vars
alias bm='vim ~/.bashrc +0 +/Bookmarks/+5'
# ---------------------------------------------------------
export sd="$HOME/fcul/3-ano/SD/grupo45/"
export iia="/home/diogo/fcul/3-ano/IIA/"
export ia="/home/diogo/fcul/3-ano/IIA/"
# ---------------------------------------------------------

alias ls='ls -F --color=auto'

# bind -x $'"\C-g":xfce4-terminal --working-directory=`pwd`;'

# Ruby Gems
# export PATH=$PATH:$(ruby -rubygems -e \
# 	'puts Gem.default_path.map {|p| p + "/bin"} .join ":"')

# export npm_config_prefix="$HOME/.local"

rr() {
    ranger --choosedir="$HOME/.rangerdir" "$@"
    cd "$(cat ~/.rangerdir)"
    rm ~/.rangerdir
}


export PS1='[\u@\h \W]\$ '
eval "$(fasd --init auto)"

alias pacsizes="expac -H M --timefmt='%Y-%m-%d' '%m\t%b\t%-30v%n' | sort -rn | less"
alias record-big='ffmpeg -video_size 1920x1080 -framerate 10 -f x11grab -i :0.0+1366,0 test.mp4'
source /usr/share/nvm/init-nvm.sh

source /home/diogo/.config/broot/launcher/bash/br

[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh
eval "$(atuin init bash)"
