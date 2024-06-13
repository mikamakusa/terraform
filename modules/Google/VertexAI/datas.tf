data "google_project" "this" {
  project_id = var.project
}

data "google_kms_key_ring" "this" {
  count    = var.kms_key_ring_name ? 1 : 0
  location = var.location
  name     = var.kms_key_ring_name
}
data "google_kms_crypto_key" "this" {
  count    = var.kms_crypto_key_name ? 1 : 0
  name     = var.kms_crypto_key_name
  key_ring = data.google_kms_key_ring.this.id
}

data "google_compute_network" "this" {
    count = var.compute_network_name ? 1 : 0
  name = var.compute_network_name
}