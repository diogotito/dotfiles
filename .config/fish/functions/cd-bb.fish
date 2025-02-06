function cd-bb
    echo -n (clear | string replace \e\[3J "")
    commandline -f repaint
    cd ~/git/bubble-blaster
    git log --oneline --graph origin/main..
    echo
    set -q argv[1] && test -d $argv[1] && cd $argv[1]
    git status --short --branch
    echo
    echo
end
