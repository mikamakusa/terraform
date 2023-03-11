resource "vsphere_compute_cluster_vm_host_rule" "host_rule" {
  for_each                      = var.host_rule
  compute_cluster_id            = each.value.compute_cluster_id
  name                          = each.key
  vm_group_name                 = each.value.vm_group_name
  affinity_host_group_name      = each.value.affinity_host_group_name
  anti_affinity_host_group_name = each.value.anti_affinity_host_group_name
  enabled                       = each.value.enabled
  mandatory                     = each.value.mandatory
}