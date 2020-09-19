# run packer builds on google cloud

## enables us to run packer builds on google cloud platform

documentation for additional settings can be found here:
https://www.packer.io/docs/builders/googlecompute.html

### This has been designed to be re-used with any GCP project + account. It is straightforward to modify the variables files in order to reuse the `build-image.sh` script to bootstrap a GCP compute image. There should be no need to modify the underlying logic in order to run this on your account, just change the variables files in the `vars` folder and the region variables depending on your preferences. The two important pieces will be the GCP credentials file location, documentation for this can be seen on the root level folder under the scripts directory, use the bootstrap.sh script which will create the relevant GCP directory on your machine. You'll need to get your credentials from the console and copy the .json file to this new GCP directory. After this you should follow the steps below, particularly the setup-account.sh script which will enable the different APIs required in order to use the image-builder. It will also enable the IAM role on your GCP project with permissions to be an 'Editor' for image resources, without this the scripts will not work.

- `./setup-account.sh` and input your gcp project_id string and this script will enable the relevant gcloud apis and update IAM permissions.
- `../scripts/symlink.sh` make sure you chmod +x to this script and then execute it you can then run the command as described below.
- `./build-image -<OPTS>` makesure you enter the directory where your gcp credentials file lives, you will also need to pass your gcp project_id in as well.
- `./build-image -h` to display the built in help menu describing what flags are available
- This script can be reused with patterns in the vm-images directory. You can take the kubernetes example in the `kube` folder and modify it to support a different image and/or use different scripts to complete different tasks on your instance.