#!/usr/bin/env bash
# setup directories needed for google cloud credentials
# setup symlink to our provison.py script to provision terraform resoruces.

SYMLINK="../scripts/provision.py"

if [ -d "${HOME}/.gcloud/creds" ]; then
    echo "Directory ${HOME}/.gcloud/creds already exists exiting script..."
else
    echo "Creating ${HOME}/.gcloud/creds/ ...."
    mkdir -p "${HOME}"/.gcloud/creds

fi

if [ -f "provison.py" ]; then
    "Symlink exists and working, exiting script..."
else
    echo "symlink broken or does not exist, creating now."
    ln -s "${SYMLINK}" provison.py
fi
