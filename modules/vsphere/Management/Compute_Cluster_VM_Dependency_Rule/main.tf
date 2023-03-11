resource "vsphere_compute_cluster_vm_dependency_rule" "dependency_rule" {
  for_each                 = var.dependency_rule
  compute_cluster_id       = each.value.compute_cluster_id
  dependency_vm_group_name = each.value.dependency_vm_group_name
  name                     = each.key
  vm_group_name            = each.value.vm_group_name
  enabled                  = each.value.enabled
  mandatory                = each.value.mandatory
}