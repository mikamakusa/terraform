resource "google_compute_network" "gc_network" {
  count        = "${length(var.network)}"
  name         = "${lookup(var.network[count.index],"name")}"
  routing_mode = "${lookup(var.network[count.index],"routing_mode")}"
  project      = "${var.project}"
  provider     = "google-beta"
}

resource "google_compute_subnetwork" "gc_subnetwork" {
  count         = "${ "${length(var.subnet)}" == "0" ? "0" : "${length(var.network)}" }"
  ip_cidr_range = "${lookup(var.subnet[count.index],"ip_cidr_range")}"
  name          = "${lookup(var.subnet[count.index],"name")}"
  network       = "${element(google_compute_network.gc_network.*.name,lookup(var.subnet,"network"))}"
  region        = "${lookup(var.subnet[count.index],"region")}"
  project       = "${var.project}"
  provider      = "google-beta"
}

resource "google_compute_global_address" "GCP_global_address" {
  project       = "${var.project}"
  provider      = "google-beta"
  name          = "${lookup(var.global_address,"name")}"
  purpose       = "${lookup(var.global_address,"purpose")}"
  address_type  = "${lookup(var.global_address,"address_type")}"
  prefix_length = "${lookup(var.global_address,"prefix_length")}"
  network       = "${google_compute_network.gc_network.self_link}"
}

resource "google_service_networking_connection" "Google_private_vpc_connection" {
  provider                = "google-beta"
  network                 = "${google_compute_network.gc_network.self_link}"
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = ["${google_compute_global_address.GCP_global_address.name}"]
}
