#!/bin/sh
SRC=$1
BIN=${SRC%.c}

line="tput setaf 1; echo {1..79}- | tr -d [:digit:][:blank:]"

while true; do
    inotifywait -e close_write $1
    clear; (sleep 0.5s && tput sgr0)&
    gcc -o $BIN $SRC && (cd `dirname $BIN` && ./`basename $BIN`; eval $line)
    #                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    #      hack para correr um executável dado qualquer tipo de path para ele
    #                 (existe alguma alternativa melhor que isto?)
done

