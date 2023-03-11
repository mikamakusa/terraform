resource "vsphere_dpm_host_override" "override" {
  compute_cluster_id   = var.override.compute_cluster_id
  host_system_id       = var.override.host_system_id
  dpm_enabled          = var.override.dpm_enabled
  dpm_automation_level = var.override.dpm_automation_level
}