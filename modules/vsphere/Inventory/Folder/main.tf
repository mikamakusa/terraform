resource "vsphere_folder" "folder" {
  path              = var.folder.path
  type              = var.folder.type
  datacenter_id     = var.folder.datacenter_id
  tags              = var.folder.tags
  custom_attributes = var.folder.custom_attributes
}