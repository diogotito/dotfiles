#!/usr/bin/env bash
# Shellcheck approves!
set -Eeuxo pipefail

GET_ID=( grep -Po "'(?<=id=)\d+'" )

function get-mouse() {
    PREVIEW_CMD=( xinput list-props \$'(' "${GET_ID[*]}" '<<<"{}")' )
    xinput |
        fzf --reverse --preview="${PREVIEW_CMD[*]}" --preview-window=down,80% |
        eval "${GET_ID[*]}"
}

xinput set-prop "$(get-mouse)" 'libinput Accel Speed' -1
