resource "vsphere_nas_datastore" "nas_datastore" {
  for_each             = var.nas_datastore
  host_system_ids      = each.value.host_system_ids
  name                 = each.key
  remote_hosts         = each.value.remote_hosts
  remote_path          = each.value.remote_path
  type                 = each.value.type
  access_mode          = each.value.access_mode
  security_type        = each.value.security_type
  folder               = each.value.folder
  datastore_cluster_id = each.value.datastore_cluster_id
  tags                 = each.value.tags
  custom_attributes    = each.value.custom_attributes
}