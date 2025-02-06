function bb
    cd ~/git/bubble-blaster
    tmux new-session \
        -A \
        -c ~/git/bubble-blaster \
        -s BadHairDay \
        sh -c "godot -e ."
    cd-bb ~/git/bubble-blaster/
end
