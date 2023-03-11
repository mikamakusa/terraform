resource "vsphere_compute_cluster_host_group" "compute_cluster_host_group" {
  for_each           = var.host_group
  compute_cluster_id = each.value.compute_cluster_id
  name               = each.key
  host_system_ids    = each.value.host_system_ids
}