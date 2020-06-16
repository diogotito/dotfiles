#
# ~/.bash_profile
#

# export JAVA_HOME=/usr/lib/jvm/java-8-openjdk

export TERMINAL="darkblue xfce4-terminal"
export EDITOR="vim"
export VISUAL=$EDITOR
export PATH=$PATH:$HOME/bin:$HOME/.screenlayout/:$HOME/.gem/ruby/2.5.0/bin
export XDG_CONFIG_HOME="$HOME/.config"
#export CLASSPATH=.:
# export PATH=$PATH:/root/.gem/ruby/2.4.0/bin


export QT_QPA_PLATFORMTHEME='qt5ct'
export PYTHONRC="$HOME/.pythonrc"

[[ -f ~/.bashrc ]] && . ~/.bashrc


source /home/diogo/.config/broot/launcher/bash/br
