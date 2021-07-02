#!/usr/bin/env bash
#{{{ Bash settings
set -o errexit   # abort on nonzero exit status
set -o nounset   # abort on unbound variable
set -o pipefail  # don't hide errors within pipes
set -o errtrace  # ERR trap is inherited by shell functions
# set -o xtrace    # show commands as they are executed
#}}}

main() {

    trap exit_stage_left EXIT ERR # Elegant exit
    install
}

exit_stage_left() {

    unset CURRENT_USER_BIN user_id user_name script_mode
    printf "\n%s\n" "Bye!"

}

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

        # cd "${CURRENT_USER_BIN}" && pwd
        curl --silent --show-error --location https://gitlab.com/msmafra/proton-get/-/raw/master/proton-get --output "${CURRENT_USER_BIN}"/proton-get
        #wget https://gitlab.com/msmafra/proton-get/-/raw/master/proton-get -O - >> proton-get
        # cd "${CURRENT_USER_BIN}" && pwd
        install --verbose -D -C --mode="${script_mode}" --owner="${user_name}" --group="${user_name}" "${CURRENT_USER_BIN}"/proton-get --target-directory="${CURRENT_USER_BIN}"
        exit 0

    fi

}

main "${@}"
