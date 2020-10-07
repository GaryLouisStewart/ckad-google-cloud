#!/usr/bin/env python3
'''
This script, maintained by @GaryLouisStewart gary.stewart@outlook.com
Uses paramiko in order to generate a 4096 bit RSA ssh key.
'''

import os
import sys
import paramiko
from pathlib import Path

private_key_path = os.getenv('PRIV_FILE')
public_key_path = os.getenv('PUB_FILE')
directory = os.getenv('DIR')

pub_file = Path(str(public_key_path))
priv_file = Path(str(private_key_path))
key = paramiko.RSAKey.generate(4096)
original_stdout = sys.stdout

def touch_file(path):
    '''
    path: takes one argument which is the path to use, this path is where the ssh-keys will be generated.
    '''
    with open(path, 'a'):
        os.utime(path, None)

def create_directory(path):
    '''
    path: this is the path where we will check if the directory exists. if the directory exists do nothing, else create it.
    '''
    try:
        os.makedirs(str(directory))
    except FileExistsError:
        pass

def write_ssh_pub(path):
    '''
    path: which path to use to generate ssh-private-key, this is the file we will write to.
    '''
    with open(path, 'w') as f:
        sys.stdout = f
        print("ssh-rsa " + key.get_base64())
        sys.stdout = original_stdout

def write_ssh_priv(path):
    '''
    path:  which path to use to generate ssh-public-key, this is the file we will write to.
    '''
    with open(path, 'w') as f:
        sys.stdout = f
        key.write_private_key(sys.stdout)
        sys.stdout = original_stdout

create_directory(directory)

# generate ssh keys based on if the file exists path existing (see private_key_path and public_key_path)

if pub_file.is_file() and priv_file.is_file():
    print("public key exists at {0} and private key exists at {1}".format(pub_file, priv_file))
else:
    if not os.path.exists(priv_file):
        touch_file(priv_file)
        write_ssh_priv(priv_file)
    if not os.path.exists(pub_file):
        touch_file(pub_file)
        write_ssh_pub(pub_file)
