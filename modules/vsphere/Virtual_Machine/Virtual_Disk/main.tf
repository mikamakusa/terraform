resource "vsphere_virtual_disk" "disk" {
  for_each           = var.disk
  datastore          = each.value.datastore
  size               = each.value.size
  type               = each.value.type
  vmdk_path          = each.value.vmdk_path
  create_directories = each.value.create_directories
  datacenter         = each.value.datacenter
}