# vim: foldmethod=marker foldlevel=0 nowrap

# START startup profiling {{{
# zmodload zsh/zprof
# -- OR --
# zmodload zsh/datetime
# setopt PROMPT_SUBST
# PS4='+$EPOCHREALTIME %N:%i> '

# logfile=$(mktemp zsh_profile.XXXXXXXX)
# echo "Logging to $logfile"
# exec 3>&2 2>$logfile

# setopt XTRACE
# }}}
# ⚡ Znap {{{
[[ -r $ZDOTDIR/znap/znap.zsh ]] ||
    git clone --depth 1 -- \
    https://github.com/marlonrichert/zsh-snap.git $ZDOTDIR/znap

source $ZDOTDIR/znap/znap.zsh  # Start Znap

# Plugins managed by Znap:
znap source "zsh-users/zsh-completions"
znap source "zsh-users/zsh-autosuggestions"
znap source "zsh-users/zsh-history-substring-search"
znap source "zdharma-continuum/fast-syntax-highlighting"
# }}}
# ⚡ Znap 3rd party things: Starship, Atuin, fasd, etc. {{{

# br (+4 ms)
source /home/diogo/.config/broot/launcher/bash/br

# Starship (+10 ms)
znap eval starship 'starship init zsh'

# if [[ -n "$SSH_CONNECTION" ]]; then
#     source bin/ipad
# fi

if [[ -n "$TMUX" ]]; then
    # tmux in iPad setup
    bindkey -s '^X^N' '^usudo nmcli connection up ^i'
    bindkey -s '^X^M' '^usudo nmcli connection down ^i'
fi


# Created by `pipx` on 2022-04-04 17:31:48
export PATH="$PATH:/home/diogo/.local/bin"

# Ruby 3.4.1
export PATH=/opt/ruby341/bin:$PATH

# rbenv (+100 ms)
znap function rbenv _rbenv_341 "znap eval rbenv 'rbenv init -'"

# atuin (+20 ms)
znap eval atuin 'atuin init zsh'

export npm_config_prefix="$HOME/.local"
export PATH=/home/diogo/.local/bin:/home/diogo/.emacs.d/bin:$PATH
export PATH=/home/diogo/.gem/ruby/3.4.1:$PATH

# fasd (+35 ms)
znap eval fasd 'fasd --init auto'
bindkey '^X^A' fasd-complete
bindkey '^X^F' fasd-complete-f
bindkey '^X^Z' fasd-complete-d

# }}}
# Load my configuration files {{{

## Aliases
source ~/.aliases              # global POSIX aliases
source $ZDOTDIR/my-aliases.zsh # ZSH-specific aliases

## zkbd
## (result of `autoload -Uz zkbd; zkbd`)
source ~/.config/zsh/.zkbd/$TERM-${${DISPLAY:t}:-$VENDOR-$OSTYPE}
[[ -n ${key[Left]} ]] && bindkey "${key[Left]}" backward-char
[[ -n ${key[Right]} ]] && bindkey "${key[Right]}" forward-char

# }}}
# ZSH customization {{{

## History
## (https://sourcegraph.com/github.com/eromatiya/the-glorious-dotfiles@f3c7cae9ec45e5b3fc8ef93063df23ccbaab3838/-/blob/home/.zshrc)

export HISTFILE=$ZDOTDIR/.zsh_history
export HISTSIZE=100000
export HISTFILESIZE=100000
export SAVEHIST=10000

setopt append_history           # Dont overwrite history
setopt extended_history         # Also record time and duration of commands.
setopt share_history            # Share history between multiple shells
setopt hist_expire_dups_first   # Clear duplicates when trimming internal hist.
setopt hist_find_no_dups        # Dont display duplicates during searches.
setopt hist_ignore_dups         # Ignore consecutive duplicates.
setopt hist_ignore_all_dups     # Remember only one unique copy of the command.
setopt hist_reduce_blanks       # Remove superfluous blanks.
setopt hist_save_no_dups        # Omit older commands in favor of newer ones.

# Changing directories
setopt autocd                   # Allow changing directories without `cd`
# setopt auto_pushd             # Make cd push the old directory onto the directory stack. 
# setopt pushd_ignore_dups      # Dont push copies of the same dir on stack.
# setopt pushd_minus            # Reference stack entries with "-".

# setopt extended_glob          # Treat the ‘#’, ‘~’ and ‘^’ characters as part of patterns for filename generation, etc. (An initial unquoted ‘~’ always produces named directory expansion.) 
#

zstyle ':completion:*' menu select
zstyle ':completion:*:*:cdr:*:*' menu selection

autoload -U select-word-style
select-word-style bash

autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

# }}}
# General shell customization {{{

export TERMINAL="xfce4-terminal"
export EDITOR="vim"
export VISUAL=$EDITOR

# }}}
# Custom keybindings {{{

# Start from Emacs-style keybindings
bindkey -e

bindkey -s '^[m' '^a{^e 2>/dev/null &} && disown\n'
bindkey -s '^[R' 'tput reset\n'
bindkey -s '^[L' 'exa --long -F --git^M'
bindkey -s '^[F' 'thunar .\n'
bindkey -s '\e[18~' 'mkdir '  # Binds F7
bindkey -s '^[S' '^p^asudo ^e'
bindkey -s '^[s' '^Udfc -c always 2>/dev/null | grep --colo=never /dev/sda7^M'
bindkey -s '^[N' '^umkdir "^y" && cd "^y"^M'

# Broken keyboard - [m] key
function nn() { bindkey -s nn m }

# tilda
function tilda() {
    xfce4-terminal --drop-down
}
zle -N tilda
bindkey '^`' tilda

# woooooooooooooooooooooooooooooow
bindkey -s '^[r' 'yy\n'
# bindkey -s '^X^P' 'zathura --fork pdf^X^F'
bindkey -s '^X^P' 'open-pdf\nexit\n'
bindkey -s '^X^K' 'kill ^i'

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

# I don't want Atuin and the FZF plugin to override some default keybindings I happen to use
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^T' transpose-chars
bindkey '^U' backward-kill-line
bindkey '^[c' capitalize-word

bindkey '^X^R' fzf-history-widget
bindkey '^X^T' fzf-file-widget

# Bind a bunch of <C-x><C-[]> sequences to common commands

bindkey -s '^[v' '^uvim^m'

bindkey -s '^X^B' '^ucdr^m'
bindkey -s '^X^I' '^usource ~/bin/ipad^m'
bindkey -s '^X^N' '^unmcli connection up ^i'
bindkey -s '^X^M' '^unmcli connection down ^i'
bindkey -s '^X^C' fzf-file-widget

# }}}
# Custom functions {{{

# Ranger
function rr() {
    ranger --choosedir=$HOME/.rangerdir "$@"
    cd "$(cat ~/.rangerdir)"
    rm ~/.rangerdir
}

# Yazi
function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

unalias run-help
function run-help() {
    man "$@" \
        || $1 --help \
        || $1 -h \
        || /usr/share/zsh/functions/Misc/run-help "$@"
}

# Use dedicaded graphics
function use-gpu() {
    set -x
    export DRI_PRIME=1
}

function which-gpu() {
    set -x
    glinfo | head -3
}


###
#
#  https://wiki.archlinux.org/index.php/zsh#File_manager_key_binds
#
###

cdUndoKey() {
  popd
  zle       reset-prompt
  print
  ls
  zle       reset-prompt
}

cdParentKey() {
  pushd ..
  zle      reset-prompt
  print
  ls
  zle       reset-prompt
}

zle -N                 cdParentKey
zle -N                 cdUndoKey
bindkey '^[[1;3A'      cdParentKey
bindkey '^[[1;3D'      cdUndoKey

# }}}
# END startup profiling {{{
# zprof
# -- OR --
# unsetopt XTRACE
# exec 2>&3 3>&-
# }}}
