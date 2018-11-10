git log --all --oneline --author="${1:-Diogo Tito Vitor Marques}" --shortstat | awk '
    BEGIN {
        FS = ","
        lines = 0
    }

    /^ / {
        match($2, /[[:digit:]]+/)
        lines += substr($2, RSTART, RLENGTH)

        match($3, /[[:digit:]]+/)
        lines += substr($3, RSTART, RLENGTH)
    }

    END {
        print lines
    }
'
