fzf --fish | source
atuin init --disable-up-arrow --disable-ctrl-r fish | source
bind \cv fish_clipboard_paste
bind \e\cr _atuin_search

# Manage ssh-agent with keychain (sudo apt install keychain)
if status --is-interactive
    keychain --eval --quiet -Q | source
end

# luarocks
set -gx LUA_PATH '/opt/luarocks/share/lua/5.3/?.lua;/usr/local/share/lua/5.3/?.lua;/usr/local/share/lua/5.3/?/init.lua;/usr/local/lib/lua/5.3/?.lua;/usr/local/lib/lua/5.3/?/init.lua;./?.lua;./?/init.lua;/home/diogo/.luarocks/share/lua/5.3/?.lua;/home/diogo/.luarocks/share/lua/5.3/?/init.lua;/opt/luarocks/share/lua/5.3/?/init.lua'
set -gx LUA_CPATH '/usr/local/lib/lua/5.3/?.so;/usr/local/lib/lua/5.3/loadall.so;./?.so;/home/diogo/.luarocks/lib/lua/5.3/?.so;/opt/luarocks/lib/lua/5.3/?.so'

# bind \eh prevd-or-backward-word  # <Alt-H> is used to get help
bind \et force-repaint

bind \er y
bind \ei cd-bb
bind \eo bb

bind \e\cl 'tput reset; commandline -f repaint'
bind \co iterate-command

abbr -a -- n nvim
abbr -a -- v nvim

# Imported abbreviations
abbr -a --position anywhere -- C '--color=always'
abbr -a --position anywhere -- G '| grep'
abbr -a --position anywhere -- L '| less'
abbr -a -- p ptpython
abbr -a -- pi ptipython
abbr -a -- bp bpython
abbr -a -- bpy bpython
abbr -a -- c code
abbr -a -- c. 'code -n .'
abbr -a -- cr 'code -r'
abbr -a -- cr. 'code -r .'
abbr -a -- cn 'code -n'
abbr -a -- cn. 'code -n .'
abbr -a -- cl 'tput reset'
abbr -a -- cls 'tput reset'
abbr -a -- d 'git diff'
abbr -a -- dc docker-compose
abbr -a -- do docker
abbr -a -- g git
abbr -a -- ga 'git add'
abbr -a -- gau 'git add --update'
abbr -a -- gb 'git branch'
abbr -a -- gc 'git commit --verbose -c@ --reset-author'
abbr -a -- gca 'git commit --verbose --amend -c@ --reset-author'
abbr -a -- gcaa 'git commit --verbose --amend -c@ --reset-author'
abbr -a -- gcaaa 'git commit --amend -C@ --reset-author --all'
abbr -a -- gd 'git diff'
abbr -a -- gdc 'git diff --cached'
abbr -a -- gfa 'git fetch --tags --prune-tags --all --force'
abbr -a --set-cursor='%' -- gg "git grep '%'"
abbr -a -- gl 'git log'
abbr -a -- glo 'git log --graph --oneline origin..'
abbr -a -- gp 'git push'
abbr -a -- gpf 'git push --force-with-lease'
abbr -a -- gpl 'git pull --ff-only --all --tags --prune --force'
abbr -a -- glp 'git pull --ff-only --all --tags --prune --force'
abbr -a -- gr 'git rebase'
abbr -a -- grc 'git rebase --continue'
abbr -a -- gri 'git rebase --interactive --autosquash --update-refs --committer-date-is-author-date'
abbr -a -- grio 'git rebase --interactive --autosquash --update-refs --committer-date-is-author-date origin'
abbr -a -- gro 'git rebase origin'
abbr -a -- gru 'git remote update'
abbr -a -- gs 'git switch'
abbr -a -- gsm 'git switch master'
abbr -a -- gsp 'git switch -'
abbr -a -- gs- 'git switch -'
abbr -a -- gsh 'git show'
abbr -a -- gst 'git status --short --branch'
abbr -a -- st 'git stash'
abbr -a --set-cursor='%' -- stm 'git stash push -m \'%\''
abbr -a -- stl 'git stash list'
abbr -a -- sta 'git stash apply --index'
abbr -a -- stp 'git stash pop'
abbr -a -- sts 'git stash show --patch'
abbr -a -- gt 'git tag'
abbr -a -- pr 'gh pr'
abbr -a -- prs 'gh pr list --author @me'
abbr -a -- s 'git status --short --branch'
abbr -a -- x 'xsel -b'
abbr -a -- zl zuul

abbr -a -- lt 'l -T'

abbr -a -- sl ls

abbr -a -- .conf 'nvim +"cd ~/.config/fish" ~/.config/fish/config.fish && source ~/.config/fish/config.fish'
abbr -a -- .fish 'nvim +"cd ~/.config/fish" ~/.config/fish/config.fish && source ~/.config/fish/config.fish'
abbr -a -- .c 'nvim +"cd ~/.config/fish" ~/.config/fish/config.fish && source ~/.config/fish/config.fish'
abbr -a -- .v 'nvim +"cd ~/.config/nvim" nvim ~/.config/nvim/init.lua'
abbr -a -- .n 'nvim +"cd ~/.config/nvim" nvim ~/.config/nvim/init.lua'
abbr -a -- .nvim 'nvim +"cd ~/.config/nvim" nvim ~/.config/nvim/init.Tua'
abbr -a -- .vim 'nvim +"cd ~/.config/nvim" nvim ~/.config/nvim/init.lua'

abbr -a --position anywhere -- ,c '~/.config/'


# Even friendlier shell
abbr -a --regex ^\\.\\.+\$ --function multicd -- dotdot

# Arch Linux
abbr -a -- S 'pacman -S'

# Project-specific aliases/abbreviations
abbr -a -- e godot

# Disabled integrations
# ---------------------
# starship init fish | source
# zoxide init fish | source
