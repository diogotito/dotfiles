#!/usr/bin/env bash
# requires jq

focused_output=$(i3-msg -t get_workspaces | jq -r '.[]|select(.focused).output')

IFS=:
i3-msg -t get_outputs | jq -r '.[]|"\(.name):\(.current_workspace)"' | grep -v 'null' | \
while read -r name current_workspace; do
    echo "moving ${current_workspace} right..."
    i3-msg "workspace --no-auto-back-and-forth ${current_workspace}" >/dev/null
    sleep 0.1s
    i3-msg "move workspace to output right" >/dev/null
    sleep 0.1s
done

echo "focusing output $focused_output"
i3-msg focus output $focused_output >/dev/null

