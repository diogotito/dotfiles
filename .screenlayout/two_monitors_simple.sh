#!/bin/sh
xrandr --output LVDS-1 --mode 1366x768            \
       --rotate normal                            \
                                                  \
       --output HDMI-1 --primary --mode 1920x1080 \
       --right-of LVDS-1                          \
       --rotate normal                            \
                                                  \
       --output VGA-1 --off                       \
                                                  \
       --output DP-1 --off

# repor o background, para aparecer como deve ser
feh --bg-fill '/home/diogo/Pictures/Wallpapers/t3_5bjy01.png'
