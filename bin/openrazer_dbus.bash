#!/usr/bin/bash

MOUSENAME=${1:-'Razer DeathAdder Chroma'}
OPENRAZER=(qdbus org.razer /org/razer)

# shellcheck disable=SC2145
# ${OPENRAZER[@]}"/device/<device> calls methods on <device>

for device in $("${OPENRAZER[@]}" getDevices); do
    if [[ $("${OPENRAZER[@]}"/device/"$device" getDeviceName) == "$MOUSENAME" ]]; then
        "${OPENRAZER[@]}"/device/"$device" setDPI 3000 3000
    fi
done

