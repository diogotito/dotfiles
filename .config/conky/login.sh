#!/bin/sh
curl 'http://192.168.0.1/goform/goform_set_cmd_process' \
    --referer 'http://192.168.0.1/index.html' \
    --data-raw 'isTest=false&goformId=LOGIN&password=YWRtaW4%3D' \
    --silent --compressed --insecure
