# run packer builds on google cloud

## enables us to run packer builds on google cloud platform

documentation for additional settings can be found here:
https://www.packer.io/docs/builders/googlecompute.html


- `./setup-account.sh` and input your gcp project_id string and this script will enable the relevant gcloud apis and update IAM permissions.
- `./build.image.sh` makesure you put your gcp project ID into the terminal.
- sit back relax and wait for your image to build