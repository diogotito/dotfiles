#!/bin/sh
export GTK2_RC_FILES=/usr/share/themes/Numix/gtk-2.0/gtkrc
export GTK_THEME=Numix
exec "$@"

export GTK_THEME=Arc
