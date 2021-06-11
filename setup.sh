#!/usr/bin/env bash
#{{{ Bash settings
set -o errexit   # abort on nonzero exit status
set -o nounset   # abort on unbound variable
set -o pipefail  # don't hide errors within pipes
set -o errtrace  # ERR trap is inherited by shell functions
# set -o xtrace    # show commands as they are executed
#}}}
declare -i install_xidel
install_xidel="${1:-}"

main() {

    trap exit_stage_left EXIT ERR # Elegant exit
    installScript "${install_xidel:-}"

}

exit_stage_left() {

    unset current_user_bin user_id user_name script_mode script_folder install_xidel temp_dir xidel_url xidel_file path_xidel
    printf "\n%s\n" "Bye!"

}

installScript() {

    local current_user_bin
    local -i user_id
    local user_name
    local -i script_mode
    local script_folder
    local install_xidel
    local temp_dir
    local xidel_url
    local xidel_file
    local path_xidel

    current_user_bin="${HOME}/.local/bin"
    user_id="$(id --user)"
    user_name="$(id --user --name)"
    script_mode="740"
    script_folder="$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"
    install_xidel="${1:-}"; shift 1

    # No super user allowed
    if [[ "${user_id}" -ne 0 ]];then

        if [[ ! -d ${current_user_bin} ]];then

            printf "%s" "The ${current_user_bin} directory doesn't exists and will now be created."
            mkdir --verbose --parent "${current_user_bin}"
            printf "%s %s %s" "Close this terminal window and open a new one, so" "${current_user_bin}" "will be included in your current PATH variable."

        fi

        path_xidel="${current_user_bin}/"
        xidel_url="https://github.com/benibela/xidel/releases/download/Xidel_0.9.8/xidel-0.9.8.linux64.tar.gz"
        xidel_file="$(printf "%s" "https://github.com/benibela/xidel/releases/download/Xidel_0.9.8/xidel-0.9.8.linux64.tar.gz" | awk -F"/" '{print $9}')"
        temp_dir="$(mktemp --directory --suffix=xidel > /dev/null 2>&1)"

        printf "%s %s \n" "-> Installing proton-get to" "${current_user_bin}"
        install --verbose -D -C --mode="${script_mode}" --owner="${user_name}" --group="${user_name}" "${script_folder}"/proton-get --target-directory="${current_user_bin}"

        if [[ ! -f "${HOME}"/.local/bin/xidel ]];then
            printf "\n%s\n%s\n%s\n" "This script uses xidel:" "https://github.com/benibela/xidel/" "https://www.videlibri.de/xidel.html"

            printf "\n%s %s\n" "-> Downloading xidel 0.9.8 (latest stable at 20210508) to " "${temp_dir}"
            printf "%s %s\n" "wget --quiet --show-progress --progress=bar --content-disposition --continue" "${xidel_url}"
            cd "${temp_dir}" && pwd
            \wget --quiet --show-progress --progress=bar --content-disposition --continue "${xidel_url}"

            printf "\n%s %s\n" "-> Extraindo arquivos em " "${temp_dir}:"
            printf "%s %s\n" "tar --get --verbose --file" "${xidel_file}"
            \tar --get --verbose --file "${xidel_file}"

            if [[ "${install_xidel:-0}" -eq 1 ]];then

                printf "\n%s\n" "-> Installing xidel to ${current_user_bin} ..."
                cd "${temp_dir}" && pwd
                install --verbose -D -C --mode="${script_mode}" --owner="${user_name}" --group="${user_name}" "${temp_dir}"/xidel --target-directory="${path_xidel}"

            fi

        fi

        "${current_user_bin}"/proton-get --version

    else

        printf "%s\n" "-> Usage of superuser/elevated privileges, is not allowed. Exiting <-"
        exit 1

    fi

}


main "${@}"
