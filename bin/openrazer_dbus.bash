#!/usr/bin/bash

DPI=${1:-3000}
MOUSENAME=${2:-'Razer DeathAdder Chroma'}

for device in $(qdbus org.razer /org/razer getDevices); do
    device_name=$(qdbus org.razer /org/razer/device/"$device" getDeviceName)
    if [[ $device_name == "$MOUSENAME" ]]; then
        set -x
        qdbus org.razer /org/razer/device/"$device" setDPI "$DPI" "$DPI"
    fi
done

