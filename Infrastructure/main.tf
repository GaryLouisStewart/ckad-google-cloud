terraform {
    required_version = ">= 0.12"
}


module "management_network" {
    source = "../modules/vpc-network"
    name_prefix = var.name_prefix
    project = var.project
    region = var.region
}


module "bastion_host" {
    source = "../modules/bastion-host"
    instance_name = "${local.resource_name}-vm"
    subnetwork = module.management_network.public_subnetwork

    project = var.project
    zone = var.zone
    name_prefix = local.resource_name
    tags = module.management_network.private
    source_image = var.boot_image
}

data "google_compute_zones" "available" {
  project = var.project
  region  = var.region
}

resource "google_compute_instance" "private" {
  count = var.instance_count
  name         = "${local.resource_name}-private-${count.index}"
  machine_type = var.instance_type
  zone         = data.google_compute_zones.available.names[count.index]

  allow_stopping_for_update = var.allow_stopping_for_update

  tags = [module.management_network.private]

  boot_disk {
    initialize_params {
      image = var.boot_image
      size = var.disk_size
      type = var.disk_type
    }
  }

  network_interface {

    subnetwork = module.management_network.private_subnetwork
  }

  metadata = {
    enable-oslogin = "TRUE"
  }
}