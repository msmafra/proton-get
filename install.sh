#!/usr/bin/env bash

install() {

    local CURRENT_USER_BIN
    local user_id
    local user_name
    local script_mode

    CURRENT_USER_BIN="${HOME}/.local/bin"
    user_id="$(id --user)"
    user_name="$(id --user --name)"
    script_mode="740"

if [[ "${user_id}" -ne 0 ]];then


    cd "${CURRENT_USER_BIN}" && pwd
    curl -fsSL https://gitlab.com/msmafra/proton-get/-/raw/master/proton-get >> proton-get
    #wget https://gitlab.com/msmafra/proton-get/-/raw/master/proton-get -O - >> proton-get
    install --verbose -D -C --mode="${script_mode}" --owner="${user_name}" --group="${user_name}" ./proton-get --target-directory="${CURRENT_USER_BIN}"

fi

}
install
