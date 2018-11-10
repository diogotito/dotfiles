#!/bin/sh
# Alternates the $mod var in my i3 config between Mod1 (Alt) and Mod4 (Super)

sed -i '/set $mod/ {s/1/t/; s/2/1/; s/t/2/}' ~/.config/i3/config

