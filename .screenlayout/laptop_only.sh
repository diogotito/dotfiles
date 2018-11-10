#!/bin/sh
xrandr --output LVDS-1 --primary \
       --mode 1366x768           \
       --pos 0x0                 \
       --rotate normal           \
       --output DP-1 --off       \
       --output HDMI-1 --off     \
       --output VGA-1 --off 

# repor o background, para aparecer como deve ser
feh --bg-fill '/home/diogo/Pictures/Wallpapers/t3_5bjy01.png'
