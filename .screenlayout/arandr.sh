#!/bin/sh
YOFFSET=-10

xrandr --output HDMI-1 --left-of LVDS-1

# xrandr --output LVDS-1 --primary --mode 1366x768 --pos 0x520 --rotate normal --output DP-1 --off --output HDMI-1 --mode 1920x1080 --pos 1366x$YOFFSET --rotate normal --output VGA-1 --off
