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
    curl -sSL https://gitlab.com/msmafra/proton-get/-/raw/master/proton-get >> proton-get
    #wget https://gitlab.com/msmafra/proton-get/-/raw/master/proton-get -O - >> proton-get
    cd "${CURRENT_USER_BIN}" && pwd
    install --verbose -D -C --mode="${script_mode}" --owner="${user_name}" --group="${user_name}" "${CURRENT_USER_BIN}"/proton-get --target-directory="${CURRENT_USER_BIN}"
    exit 0

fi

}
install
