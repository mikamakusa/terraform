resource "vsphere_storage_drs_vm_override" "drs_vm_override" {
  datastore_cluster_id   = var.drs_vm_overrides.datastore_cluster_id
  virtual_machine_id     = var.drs_vm_overrides.virtual_machine_id
  sdrs_enabled           = var.drs_vm_overrides.sdrs_enabled
  sdrs_automation_level  = var.drs_vm_overrides.sdrs_automation_level
  sdrs_intra_vm_affinity = var.drs_vm_overrides.sdrs_infra_vm_affinity
}