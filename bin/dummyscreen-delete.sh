#!/bin/sh
# Virtual desktop without Dummy Display Plugs - Delete
# https://github.com/pavlobu/deskreen/discussions/37

xrandr --output VIRTUAL1 --off
xrandr --delmode VIRTUAL1 extraScreen
xrandr --rmmode extraScreen
