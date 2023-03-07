resource "vsphere_vmfs_datastore" "vmfs_datastore" {
  for_each             = var.vmfs_datastore
  disks                = each.value.disks
  host_system_id       = each.value.host_system_id
  name                 = each.key
  folder               = each.value.folder
  datastore_cluster_id = each.value.datastore_cluster_id
  tags                 = each.value.tags
}