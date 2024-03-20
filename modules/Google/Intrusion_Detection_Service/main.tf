resource "google_compute_global_address" "this" {
  count       = length(var.global_address)
  name        = lookup(var.global_address[count.index], "name")
  address     = lookup(var.global_address[count.index], "address")
  description = lookup(var.global_address[count.index], "description")
  labels = merge(
    var.labels,
    lookup(var.global_address[count.index], "labels")
  )
  ip_version    = lookup(var.global_address[count.index], "ip_version")
  prefix_length = lookup(var.global_address[count.index], "prefix_length")
  address_type  = lookup(var.global_address[count.index], "address_type")
  purpose       = lookup(var.global_address[count.index], "pupose")
  network       = data.google_compute_network.this.id
  project       = data.google_compute_network.this.project
}

resource "google_service_networking_connection" "this" {
  count   = length(var.networking_connection)
  network = data.google_compute_network.this.id
  reserved_peering_ranges = try(
    element(google_compute_global_address.this.*.name, lookup(var.networking_connection[count.index], "service_id"))
  )
  service = lookup(var.networking_connection[count.index], "service")
}

resource "google_cloud_ids_endpoint" "this" {
  count             = length(var.ids_endpoint)
  location          = lookup(var.ids_endpoint[count.index], "location")
  name              = lookup(var.ids_endpoint[count.index], "name")
  network           = data.google_compute_network.this.id
  severity          = lookup(var.ids_endpoint[count.index], "severity")
  description       = lookup(var.ids_endpoint[count.index], "description")
  threat_exceptions = lookup(var.ids_endpoint[count.index], "threat_exceptions")
  project           = data.google_compute_network.this.project
}