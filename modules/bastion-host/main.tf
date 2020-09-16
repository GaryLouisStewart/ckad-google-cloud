terraform {
    required_version = ">= 0.12"
}

resource "google_compute_instance" "bastion_host" {
    project = var.project
    name = "${var.name_prefix}-bastion-host"
    machine_type = var.machine_type
    zone = var.zone

    tags = [var.tags]

    boot_disk {
        initialize_params {
            image = var.source_image
        }
    }

    network_interface {
        subnetwork = var.subnetwork

        access_config {
            nat_ip = var.static_ip
        }
    }

    metadata_startup_script = var.startup_script

    metadata = {
        enable-oslogin = "TRUE"
    }
}


