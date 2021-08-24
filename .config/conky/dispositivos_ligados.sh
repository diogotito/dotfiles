#!/bin/sh
curl 'http://192.168.0.1/goform/goform_get_cmd_process?cmd=station_list' \
     --referer http://192.168.0.1/index.html \
     --silent --insecure \
        | jq -r '.[][] | map(.) | @tsv' \
        | cut -f 2- | column -t
