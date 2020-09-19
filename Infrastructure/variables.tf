variable "credentials_file" {
    description = "The default google cloud credentials file to use."
}

variable "project" {
    description = "The default google cloud project id/name"
}

variable "region" {
    description = "The default region to use with our gcloud project"
}

variable "vpc_ip_range" {
    description = "The ip address range of our VPC"
}

variable "autocreate_subnetworks" {
    description = "Boolean, whether to create a subnetwork on our default vpc, defaults to false."
}

variable "subnet_count" {
    description = "The amount of subnets to create"
}

variable "name_prefix" {
    description = "The name prefix to use for our Infrastructure"
}

variable "cidr_block" {
    description = "The CIDR block to use for our vpc subnets"
}

variable "cidr_subnet_width" {
    description = "The CIDR subnet width to use"
}

variable "zone" {
    description = "The zone within the region in which to launch our vm instances"
}

variable "instance_count" {
    description = "the number of instances to create"
}

variable "instance_type" {
    description = "The instance size to use."
}

variable "bootscript" {
    description = "the bootscript to use"
    default = ""
}

variable "boot_image" {
    description = "The image to use for booting our gcp servers"
}

variable "allow_stopping_for_update" {
    description = "Whether to allow us to stop our instance for updates."
}


variable "disk_size" {
    description = "The size of the boot disk."
}

variable "disk_type" {
    description = "The type of disk to use"
}
