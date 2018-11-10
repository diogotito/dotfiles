#!/bin/sh
clips <<EOF | sed '1d; /CLIPS> /,/CLIPS> /d'
    (load "$1")
    (reset)
    (defrule aaaaaaaaaaaaaaaaa
        (declare (salience 10000))
    =>
        (printout t "qwertyuiop" crlf))
    (run)
    (exit)
EOF
echo

