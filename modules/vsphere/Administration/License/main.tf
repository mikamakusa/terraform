resource "vsphere_license" "license" {
  license_key = var.license

  labels = var.labels
}