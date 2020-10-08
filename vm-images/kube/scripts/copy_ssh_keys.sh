#!/usr/bin/env bash
# copy over the public key into authorised ssh keys for this image
# set correct permissions on the directory.


commands=(
    "chmod 700 ${HOME}/.ssh"
    "chmod 600 ${HOME}/.ssh/authorized_keys"
    "chmod 400 ${HOME}/.ssh/kube"
)

# create authorized_keys file in .ssh directory.
cat "${HOME}"/.ssh/kube.pub >> "${HOME}"/.ssh/authorized_keys

# loop over commands array variable and execute each string as a command.
for i in "${commands[@]}"; do
    $i
done