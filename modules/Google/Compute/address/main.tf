resource "google_compute_address" "address" {
  count        = length(var.address)
  name         = lookup(var.address[count.index], "name")
  description  = lookup(var.address[count.index], "description", null)
  region       = var.region
  project      = var.project
  purpose      = lookup(var.address[count.index], "purpose" null)
  network_tier = lookup(var.address[count.index], "network_tier", null)
  subnetwork   = lookup(var.address[count.index], "subnetwork", null)
  address_type = lookup(var.address[count.index], "address_type", null)
  address      = lookup(var.address[count.index], "address", null)
  labels       = lookup(var.address[count.index], "labels", null)
}
