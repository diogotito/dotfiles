function fish_greeting
    set -l title_color (set_color normal)(set_color blue --underline)
    set -l body_color (set_color normal)(set_color white --dim)
    set -l mod_color (set_color normal)(set_color cyan)
    set -l key_color (set_color normal)(set_color green --bold)
    echo
    echo $title_color"Shortcuts:"$body_color
    echo "  - "$mod_color"Alt"$body_color" + "$key_color"I"$body_color" --> cd ~/git/bubble-blaster     "
    echo "  - "$mod_color"Alt"$body_color" + "$key_color"O"$body_color" --> cd ~/git/bubble-blaster and start editor     "
    echo
end
