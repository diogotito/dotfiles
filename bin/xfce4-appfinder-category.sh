#!/bin/bash
#
# Opens XFCE4's Application Finder in a given category
# ("All Applications" by default)

appfinder-category() {
    xfconf-query -c xfce4-appfinder -p /last/category -n -t string "$@"
}

OLD_CAT=$(appfinder-category)

appfinder-category -s "${1:-"All Applications"}"
xfce4-appfinder
appfinder-category -s "$OLD_CAT"

