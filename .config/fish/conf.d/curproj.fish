set -g curproj_dir  ~/git/bubble-blaster
set -g curproj_name BadHairDay
set -g curproj_cmd  "godot -e ."

function curproj_open
    cd $curproj_dir
    tmux new-session \
        -A \
        -c $curproj_dir \
        -s $curproj_name \
        sh -c "$curproj_cmd"
    curproj_cd
end

function curproj_cd
    echo -n (clear | string replace \e\[3J "")
    commandline -f repaint
    cd $curproj_dir
    git log --oneline --graph origin/main..
    echo
    set -q argv[1] && test -d $argv[1] && cd $argv[1]
    git status --short --branch
    echo
    echo
end

function curproj_greet
    set -l title_color (set_color normal)(set_color blue --underline)
    set -l text_color (set_color normal)(set_color white)
    set -l body_color (set_color normal)(set_color white --dim)
    set -l mod_color (set_color normal)(set_color cyan)
    set -l key_color (set_color normal)(set_color green --bold)
    echo
    echo $title_color"Project shortcuts:"$body_color
    echo "  - "$mod_color"Alt"$body_color" + "$key_color"I"$body_color" --> cd $curproj_dir     "
    echo "  - "$mod_color"Alt"$body_color" + "$key_color"O"$body_color" --> cd $curproj_dir and start editor     "
    echo "  - "$text_color".cp"$body_color" --> edit ~/.config/fish/conf.d/curproj.fish     "
    echo
end

bind \ei curproj_cd
bind \eo curproj_open
