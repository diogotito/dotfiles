#!/bin/sh

THEME=Numix-Archblue

export GTK2_RC_FILES=/usr/share/themes/$THEME/gtk-2.0/gtkrc
export GTK_THEME=$THEME
export MOZ_USE_XINPUT2=1 
exec firefox

