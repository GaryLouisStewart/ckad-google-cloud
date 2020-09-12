#!/usr/bin/env python3

from datetime import datetime
import argparse
import os
import sys
from subprocess import Popen, PIPE
import subprocess

path = os.getcwd()
vars_path = path + "/vars"
log_path = path + "/logs"

if os.path.exists(log_path):
    print("The following log path: {0} already exists, continuing".format(log_path))
else:
    os.mkdir(log_path)

# parser arguments, please do not modify
parser = argparse.ArgumentParser()
parser.add_argument('-i', help='runs a terraform init'), parser.add_argument('-a', help='runs a terraform Apply')
parser.add_argument('-p', help='runs a terraform Plan'), parser.add_argument('-d', help='runs a terraform Destroy')
parser.add_argument('-o', help='runs a terraform output'), parser.add_argument('-debug', help='debugging mode Plan')
args = parser.parse_args()
# end parser arguments.


def get_date():
    current_date = datetime.now()
    cd_string = current_date.strftime("%d-%m-%Y-%H:%M:%S")
    return f"{cd_string}"


def initialise():
    try:
        process = Popen(['terraform', 'init'], cwd=path, stdout=PIPE, stderr=PIPE)
        stdout, stderr = process.communicate()
        return print(stdout.decode(), stderr.decode())
    except subprocess.CalledProcessError:
        return f"Warning could not initialize terraform in the follow directory: {0} \n".format(path),\



def plan():
    prefix = sys.argv[2]
    variable_location = vars_path + "/" + prefix + ".json"
    logfile = "terraform-plan-log-" + get_date()
    try:
        process = Popen(['terraform', 'plan', '-var-file={0}'.format(variable_location),
                         '-out={0}'.format(log_path + "/" + logfile)], cwd=path, stdout=PIPE, stderr=PIPE)
        stdout, stderr = process.communicate()
        return print(stdout.decode(), stderr.decode())
    except subprocess.CalledProcessError:
        return f"Warning could not run a terraform plan in the following directory: {0} \n".format(path),\
               "Please make sure that a variables file exists in the following location {0}".format(variable_location)


def apply():
    prefix = sys.argv[2]
    variable_location = vars_path + "/" + prefix + ".json"
    try:
        process = Popen(['terraform', 'apply', '-var-file={0}'.format(variable_location)],
                        cwd=path, stdout=PIPE, stderr=PIPE)
        stdout, stderr = process.communicate()
        return print(stdout.decode(), stderr.decode())
    except subprocess.CalledProcessError:
        return f"Warning could not run a terraform Apply in the following directory: {0} \n".format(path),\
               "Please make sure that a variables file exists in the following location {0}".format(variable_location)


def destroy():
    prefix = sys.argv[2]
    variable_location = vars_path + "/" + prefix + ".json"
    try:
        process = Popen(['terraform', 'destroy', '-var-file={0}'.format(variable_location)],
                        cwd=path, stdout=PIPE, stderr=PIPE)
        stdout, stderr = process.communicate()
        return print(stdout.decode(), stderr.decode())
    except subprocess.CalledProcessError:
        return f"Warning could not run a terraform plan in the following directory: {0} \n".format(plan),\
               "Please make sure that a variables file exists in the following location {0}".format(variable_location)


def output():
    resourcename = sys.argv[2]
    try:
        process = Popen(['terraform', 'output', '{0}'.format(resourcename)],
                        cwd=path, stdout=PIPE, stderr=PIPE)
        stdout, stderr = process.communicate()
        return print(stdout.decode(), stderr.decode())
    except subprocess.CalledProcessError:
        return f"Warning could not run a terraform output in the following directory: {0} \n".format(path),\
                "Please make sure the resource name: {0} is defined within the terraform code".format(resourcename)


def debug_mode():
    prefix = sys.argv[2]
    variable_location = vars_path + "/" + prefix + ".json"
    logfile = "terraform-plan-log-" + get_date()
    os.environ['TF_LOG'] = 'debug'
    try:
        process = Popen(['terraform', 'plan', '-var-file={0}'.format(variable_location),
                         '-out={0}'.format(log_path + "/" + logfile)], cwd=path, stdout=PIPE, stderr=PIPE)
        stdout, stderr = process.communicate()
        return print(stdout.decode(), stderr.decode())
    except subprocess.CalledProcessError:
        return f"Warning could not run a terraform plan in the following directory: {0} \n".format(path),\
               "Please make sure that a variables file exists in the following location {0}".format(variable_location)


def exec_main(arg):
    option[arg]()


option = {'-i': initialise,
          '-p': plan,
          '-a': apply,
          '-d': destroy,
          '-o': output,
          '-debug': debug_mode
          }


flag = sys.argv[1]

if __name__ == "__main__":
    print("Beginning execution using {0}".format(sys.argv[0]))
    exec_main(flag)