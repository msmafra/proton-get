#!/usr/bin/env bash
#{{{ Bash settings
set -o errexit   # abort on nonzero exit status
set -o nounset   # abort on unbound variable
set -o pipefail  # don't hide errors within pipes
set -o errtrace  # ERR trap is inherited by shell functions
#set -o xtrace    # show commands as they are executed
#}}}

main() {
    trap exit_stage_left EXIT ERR # Elegant exit
    installScript
}

exit_stage_left() {
    unset userId userName scriptMode scriptFolder
    printf "\n%s\n" "Bye!"
}

installScript() {
    local -i userId
    local userName
    local -i scriptMode
    local scriptFolder
    userId="$(id --user)"
    userName="$(id --user --name)"
    scriptMode="740"
    scriptFolder="$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"

    if [[ ${userId} -ne 0 ]];then # No super user
        printf "%s\n" "Installing proton-get to ${HOME}/.local/bin ..."
        install --verbose -D --mode="${scriptMode}" --owner="${userName}" --group="${userName}" "${scriptFolder}"/proton-get --target-directory="${HOME}"/.local/bin
    fi

    }

main "${@}"
