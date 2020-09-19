#!/usr/bin/env bash
# specific script for building the required packer images on google cloud

# local script env vars
DATE_WITH_TIME=$(date "+%Y%m%d-%H%M%S")
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source "${DIR}/scripts/path.sh"
PACKER_LOG=1
PACKER_LOG_PATH="${LOG_PATH}-${DATE_WITH_TIME}"
# end local script env vars

read -rp "Please enter the name of your gcloud credentials file here: " CREDS
read -rp "Please enter your GCP project ID here: " PROJECT_ID


[[ -d "${LOG_PATH}/packer-${DATE_WITH_TIME}" ]] || mkdir -p "${LOG_PATH}/packer-${DATE_WITH_TIME}"

function packer_build() {
      echo "Building packer image for kubernetes nodes: ...........%"
      packer build -timestamp-ui -var-file "${VARS_PATH}"/packer-vars.json -var account_file="${HOME}/.gcloud/creds/${CREDS}" -var project_id="${PROJECT_ID}" "${VARS_PATH}"/packer.json
}

function remove_old_dir() {
    rm -rvf "${LOG_PATH}"
}


function usage() {
    echo "Usage: ./build-image.sh <opts>, You will need to specify your GCP credentials file which should be in a (.json format) and your GCP project ID"
    echo "Build | FLG | build, -b | Builds the raw packer-image on google cloud"
    echo "Remove DIR | FLG | rmdir,-rm | Removes the logs directory"
    echo "Print Help | FLG | help, -h | Prints out this helper text"
}

opt=$1
case $opt
in

build|-b)
    packer_build "$@"
    ;;
rmdir|-rm)
    remove_old_dir
    ;;
help|-help)
    usage
    ;;
*)
    echo "Invalid Usage: please run \$build.sh -help"
esac