resource "vsphere_ha_vm_override" "override" {
  compute_cluster_id = var.compute_cluster_id
  virtual_machine_id = var.virtual_machine_id

  ha_vm_restart_priority     = var.general_ha.ha_vm_restart_priority
  ha_vm_restart_timeout      = var.general_ha.ha_vm_restart_timeout
  ha_host_isolation_response = var.general_ha.ha_host_isolation_response

  ha_datastore_pdl_response        = var.ha_virtual_machine.ha_datastore_pdl_response
  ha_datastore_apd_response_delay  = var.ha_virtual_machine.ha_datastore_apd_response_delay
  ha_datastore_apd_response        = var.ha_virtual_machine.ha_datastore_apd_response
  ha_datastore_apd_recovery_action = var.ha_virtual_machine.ha_datastore_apd_recovery_action

  ha_vm_monitoring                      = var.monitoring_settings.ha_vm_monitoring
  ha_vm_monitoring_use_cluster_defaults = var.monitoring_settings.ha_vm_monitoring_use_cluster_defaults
  ha_vm_failure_interval                = var.monitoring_settings.ha_vm_failure_interval
  ha_vm_minimum_uptime                  = var.monitoring_settings.ha_vm_minimum_uptime
  ha_vm_maximum_resets                  = var.monitoring_settings.ha_vm_maximum_resets
  ha_vm_maximum_failure_window          = var.monitoring_settings.ha_vm_maximum_failure_window
}