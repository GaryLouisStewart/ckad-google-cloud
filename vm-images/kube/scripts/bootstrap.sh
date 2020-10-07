#!/usr/bin/env bash
# complete some basic tasks before exectuing our python script.

sudo apt-get update && sudo apt install -y python3-pip

cat <<EOF > requirements.txt

paramiko==2.7.2
EOF

pip3 install -r requirements.txt