resource "vsphere_file" "file" {
  datastore          = var.datastore
  destination_file   = var.destination_file
  source_file        = var.source_file
  source_datacenter  = var.source_datacenter
  source_datastore   = var.source_datastore
  datacenter         = var.datacenter
  create_directories = var.create_directories
}