resource "vsphere_drs_vm_override" "override" {
  compute_cluster_id   = var.override.compute_cluster_id
  virtual_machine_id   = var.override.virtual_machine_id
  drs_enabled          = var.override.drs_enabled
  drs_automation_level = var.override.drs_automation_level
}