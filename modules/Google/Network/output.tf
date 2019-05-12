output "network_self_link" {
  value = "${google_compute_network.gc_network.self_link}"
}

output "subnet_self_link" {
  value = "${google_compute_subnetwork.gc_subnetwork.self_link}"
}

output "global_address_self_link" {
  value = "${google_compute_global_address.GCP_global_address.self_link}"
}