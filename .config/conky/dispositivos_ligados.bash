#!/bin/bash
#shellcheck disable=SC2016
set -Eeuo pipefail

function obter-lista() {
    curl 'http://192.168.0.1/goform/goform_get_cmd_process?cmd=station_list' \
        --referer 'http://192.168.0.1/index.html' \
        --silent --insecure \
            | jq -r '.[][] | map(.) | @tsv' \
            | awk '{ print "${font1}" $2, "${alignr}${font2}" $3 }'
}

function login-router() {
    echo 'Logging in...' >&2
    cat <<-'EOM'
		${alignc}Espera...
		${voffset -12}${hr}${voffset -8}
		Estou a fazer login novamente para
		ir buscar a lista de dispositivos 
		ligados
		${voffset -12}${hr}
		EOM
    curl 'http://192.168.0.1/goform/goform_set_cmd_process' \
        --referer 'http://192.168.0.1/index.html' \
        --data-raw 'isTest=false&goformId=LOGIN&password=YWRtaW4%3D' \
        --compressed --insecure
}

function nao-ha-router() {
    cat <<-'EOM'
		${voffset -28}${color red}${shadecolor orange}${alignc}Erro!
		${voffset -12}${hr}${voffset -8}
		${alignc}Não estamos ligados ao router!
		${voffset -11}${hr}
		EOM
}

obter-lista || login-router || nao-ha-router
