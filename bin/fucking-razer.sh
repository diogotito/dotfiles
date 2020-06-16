#!/bin/bash

set -Eeuxo pipefail
# set +xe


# MOUSE_ID=$(xinput | grep DeathAdder            \
#                   | grep pointer               \
#                   | grep -v "Consumer Control" \
#                   | cut -d $'\t' -f 2          \
#                   | cut -d = -f 2)
# 
# echo "xinput device ID: $MOUSE_ID"
# 
# xinput set-prop "$MOUSE_ID" 'libinput Accel Speed' "${1:--1.00}"

# xinput set-prop \
#     'pointer:Razer Razer DeathAdder Chroma' \
#     'libinput Accel Speed' \
#     "${1:--1.00}"

# JESUS FUCKING CHRIST
# xinput set-prop 10 315 -1
xinput set-prop 10 317 -1

# if [ -x "$(command -v razercfg)" ]; then
#     # Activate profile 1 (Desktop)
#     razercfg -p 1
# fi

# TODO: try changing mouse speed through Open Razer

