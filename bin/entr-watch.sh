#!/bin/sh
# watch - rebuild a project if any file in the current directory is added,
# removed or modified
# Eric Radman, 2015
# http://entrproject.org/scripts/

COMMAND="$@"
[ -z "$COMMAND" ] && COMMAND="make"

# Sleep to allow Ctrl-C to operate
while sleep .5; do
	# Exclude directories and files that start with .*
	echo "Watching $PWD"
	find $PWD -name ".*" -prune -o -print | entr -d $COMMAND
done
