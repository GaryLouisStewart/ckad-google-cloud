output "instance" {
    description = "a reference to the bastion hosts VM instance"
    value       = google_compute_instance.bastion_host.self_link
}

output "address" {
    description = "The public IP of the bastion host."
    value = google_compute_instance.bastion_host.network_interface[0].access_config[0].nat_ip
}

output "private_ip" {
    description = "The private IP address of the bastion host"
    value = google_compute_instance.bastion_host.network_interface[0].network_ip
}