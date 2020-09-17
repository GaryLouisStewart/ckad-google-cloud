#!/usr/bin/env bash
# builds the required packer images.

DATE_WITH_TIME=$(date "+%Y%m%d-%H%M%S")
PACKER_LOG=1
PACKER_LOG_PATH="$(pwd)./logs-\"$DATE_WITH_TIME\""
directory=logs

read -rp "Please enter the name of your gcloud credentials file here: " CREDS
read -rp "Please enter your GCP project ID here: " PROJECT_ID


[[ -d $(pwd)/.logs ]] || mkdir -p "$(pwd)"./logs

function packer_build() {
      echo "Building packer image for kubernetes nodes: ...........%"
      packer build -timestamp-ui -var-file packer-vars.json -var account_file="${HOME}/.gcloud/creds/${CREDS}" -var project_id="${PROJECT_ID}" packer.json
}

function remove_old_dir() {
    rm -rvf $directory
}


function usage() {
    echo "Usage: ./openvpn_build.sh <opts>"
    echo "Build | FLG | build, -b | Builds the raw packer-image"
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