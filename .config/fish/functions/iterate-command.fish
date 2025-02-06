function iterate-command
    set -l command (commandline)
    set -l cursor (commandline -C)
    commandline -C $cursor

    tput reset
    printf '\e[36m❯ %s\e[0m\n%s' $command (string repeat -n $COLUMNS '┈')

    function _recall_command --on-event fish_prompt -V command -V cursor
        commandline -f execute
        commandline $command
        functions --erase _recall_command
    end
end
