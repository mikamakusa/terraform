resource "vsphere_compute_cluster_vm_group" "vm_group" {
  for_each            = var.vm_group
  compute_cluster_id  = each.value.compute_cluster_id
  name                = each.key
  virtual_machine_ids = each.value.virtual_machine_ids
}