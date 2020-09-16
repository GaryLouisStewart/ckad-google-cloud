# ckad-google-cloud
CKAD materials with google cloud + terraform

Firstly inspiration for this has come from gruntwork on the following repo, this uses the modules there to define a management network + firewall + bastion host
https://github.com/gruntwork-io/terraform-google-network


The two most important variables are the `credentials-file` and the `project`
make sure these are filled in I have excluded them from the vars/ckad-infra file on purpose as they include personal information.
You should also make sure the `region` variable matches the default region on your gcloud project.


run terraform commands with the following instructions:
- requires python 3, make sure you have it installed
- browse to the scripts folder
- `chmod +x provision.py`
- browse to the infrastructure folder
- run `./scripts/bootstrap.sh` to create the necessary symlink
- run `./provision.py -i .` to initialize the directory
- run `./provision.py -p ckad-infra`