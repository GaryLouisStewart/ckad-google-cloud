#!/usr/bin/env bash
# copy over the public key into authorised ssh keys for this image.

sudo bash -c "cat /${HOME}/.ssh/kube.pub >> /${HOME}/.ssh/authorized_keys"
chmod 400 /${HOME}/.ssh/kube