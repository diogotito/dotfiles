#!/bin/bash
#
# Opens XFCE4's Application Finder in a given category
# ("All Applications" by default)


# Get or set (with -s/--set) the category in the Application Finder
appfinder-category() {
    xfconf-query \
        --channel xfce4-appfinder --property /last/category \
        --create --type string "$@"
}


NEW_CAT=${1:-"All Applications"}
OLD_CAT=$(appfinder-category)
shift

appfinder-category --set "$NEW_CAT"
xfce4-appfinder "$@"
appfinder-category --set "$OLD_CAT"

