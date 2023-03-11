resource "vsphere_compute_cluster_vm_anti_affinity_rule" "anti_affinity_rule" {
  for_each            = var.anti_affinity_rule
  compute_cluster_id  = each.value.compute_cluster_id
  name                = each.key
  virtual_machine_ids = each.value.virtual_machine_ids
  enabled             = each.value.enabled
  mandatory           = each.value.mandatory
}