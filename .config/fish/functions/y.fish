function y
    set -l _yazi_cwd_file (mktemp /tmp/tmp.yazi.cwd_file.XXX)
    yazi --cwd-file $_yazi_cwd_file
    cd (cat $_yazi_cwd_file)
    rm $_yazi_cwd_file
    commandline -f repaint
end
