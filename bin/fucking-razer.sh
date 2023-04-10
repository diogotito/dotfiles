#!/bin/bash

set -Eeuxo pipefail
# set +xe


#------------------------------------------
# Razer DeathAdder
#------------------------------------------
# xinput | grep DeathAdder            \
#        | grep pointer               \
#------------------------------------------
# whatever this gaming mouse is
#------------------------------------------
xinput | grep 'SINOWEALTH Game Mouse' \
       | cut -d $'\t' -f 2            \
       | cut -d = -f 2                \
       | while read -r mouse_id; do
             xinput set-prop "$mouse_id" 'libinput Accel Speed' "${1:--1.00}" \
                 && break
         done


# xinput | awk --field-separator '\t|=' --assign speed="${1:--1.00}" '
#     /Razer DeathAdder/ && /pointer/ && !/Consumer Control/ {
#         system("xinput set-prop " $3 " \"libinput Accel Speed\" $speed")
#     }'

qdbus org.razer /org/razer/device/SI1542121721077 razer.device.dpi.setDPI "${2:-3000}" "${2:-3000}"

# echo "xinput device ID: $MOUSE_ID"

# xinput set-prop \
#     'pointer:Razer Razer DeathAdder Chroma' \
#     'libinput Accel Speed' \
#     "${1:--1.00}"

# JESUS FUCKING CHRIST
# xinput set-prop 10 315 -1
# xinput set-prop 10 317 -1

# if [ -x "$(command -v razercfg)" ]; then
#     # Activate profile 1 (Desktop)
#     razercfg -p 1
# fi

# TODO: try changing mouse speed through Open Razer

