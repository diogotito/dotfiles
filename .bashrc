#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export HISTSIZE=1000000
export HISTFILESIZE=${HISTSIZE}
export HISTCONTROL=ignoreboth

# Ruby Gems
# export PATH=$PATH:$(ruby -rubygems -e \
# 	'puts Gem.default_path.map {|p| p + "/bin"} .join ":"')

alias ls='ls --color=auto'
alias du='du -h'

alias pp='ping -c 4 8.8.8.8'

function rr() {
    ranger --choosedir=$HOME/.rangerdir
    cd $(cat ~/.rangerdir)
    rm ~/.rangerdir
}

export PS1='[\u@\h \W]\$ '

