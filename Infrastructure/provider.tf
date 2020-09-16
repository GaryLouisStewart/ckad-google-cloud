terraform {
    required_version = ">= 0.12"
}

provider "google" {
    credentials = file(var.credentials_file)
    project = var.project
    region = var.region
}
