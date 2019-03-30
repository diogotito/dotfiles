#!/bin/sh

set -Eeuxo pipefail

MOUSE_ID=$(xinput | grep DeathAdder            \
                  | grep pointer               \
                  | grep -v "Consumer Control" \
                  | cut -d $'\t' -f 2          \
                  | cut -d = -f 2)

xinput set-prop $MOUSE_ID 'libinput Accel Speed' ${1:--1.00}

