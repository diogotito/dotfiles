#!/bin/bash

ROUTER_SSID='Hotspot_MEO-B9C30B'
CONKY_CONF=~/.config/conky/conky.conf

for (( i = 0; i < 10; i++ ))
do
    if nmcli --get-values=TYPE,STATE,CONNECTION device |
        grep "wifi:connected:$ROUTER_SSID" >/dev/null
    then
        conky -c $CONKY_CONF & disown
        exit
    fi
    sleep 2s
done
