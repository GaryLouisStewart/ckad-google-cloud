#!/usr/bin/env bash
# setup our gcloud account with relevant APIS and access to allow us to run packer-builds.

read -rp "Please enter your gcloud project_id here: " PROJECT

function Enable_apis() {
    gcloud services enable sourcerepo.googleapis.com
    gcloud services enable compute.googleapis.com
    gcloud services enable servicemanagement.googleapis.com
    gcloud services enable storage-api.googleapis.com
    gcloud services enable cloudbuild.googleapis.com
}

function setup_cloud_build_serviceaccount() {
    project_id=${PROJECT}
    cloud_build_account=$(gcloud projects get-iam-policy "${project_id}" --filter="(bindings.role:roles/cloudbuild.builds.builder)"  --flatten="bindings[].members" --format="value(bindings.members[])")
    gcloud projects add-iam-policy-binding "${project_id}" \
      --member "${cloud_build_account}" \
      --role roles/editor

}

Enable_apis
setup_cloud_build_serviceaccount