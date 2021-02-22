#!/bin/bash
# Virtual desktop without Dummy Display Plugs - Create
# https://github.com/pavlobu/deskreen/discussions/37
set -euxo pipefail

# remoteHScreen=2560
# remoteVScreen=1600
remoteHScreen=2160  # iPad 8th gen
remoteVScreen=1620  # iPad 8th gen
((remoteHScreen /= 2))
((remoteVScreen /= 2))
refreshRate=60
existingScreenName="LVDS1"  # Built-in screen

params=$(gtf ${remoteHScreen} ${remoteVScreen} ${refreshRate} | grep Modeline | sed 's/^\s\sModeline \".*\"\s*//g')

# shellcheck disable=2086
xrandr --newmode "extraScreen" $params  # $params needs to be splitted
xrandr --addmode VIRTUAL1 extraScreen
xrandr --output VIRTUAL1 --left-of ${existingScreenName} --mode extraScreen
