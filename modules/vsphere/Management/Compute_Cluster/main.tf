resource "vsphere_compute_cluster" "compute_cluster" {
  datacenter_id     = data.vsphere_datacenter.dc.id
  name              = var.cluster_name
  folder            = var.folder_name == null ? "" : var.folder_name
  tags              = var.tags
  custom_attributes = var.custom_attributes == null ? {} : var.custom_attributes

  host_system_ids           = [data.vsphere_host.hosts.*.id]
  host_cluster_exit_timeout = ""
  force_evacuate_on_destroy = ""

  drs_enabled               = var.drs.enabled
  drs_automation_level      = var.drs.automation_level
  drs_migration_threshold   = var.drs.migration_threshold
  drs_enable_vm_overrides   = var.drs.enable_vm_overrides
  drs_enable_predictive_drs = var.drs.enable_predictive_drs
  drs_advanced_options      = var.drs.advanced_options

  dpm_enabled          = var.dpm.enabled
  dpm_automation_level = var.dpm.automation_level
  dpm_threshold        = var.dpm.threshold

  ha_enabled                                            = var.ha.enabled
  ha_host_monitoring                                    = var.ha.host.monitoring
  ha_host_isolation_response                            = var.ha.host.isolation_response
  ha_vm_restart_priority                                = var.ha.vm.restart_priority
  ha_vm_dependency_restart_condition                    = var.ha.vm.dependency_restart_condition
  ha_vm_restart_additional_delay                        = var.ha.vm.restart_additional_delay
  ha_vm_component_protection                            = var.ha.vm.component_protection
  ha_vm_monitoring                                      = var.ha.vm.monitoring
  ha_vm_failure_interval                                = var.ha.vm.failure_interval
  ha_vm_minimum_uptime                                  = var.ha.vm.minimum_uptime
  ha_vm_maximum_resets                                  = var.ha.vm.maximum_resets
  ha_vm_maximum_failure_window                          = var.ha.vm.maximum_failure_window
  ha_advanced_options                                   = var.ha.vm.advanced_options
  ha_datastore_pdl_response                             = var.ha.datastore.pdl_response
  ha_datastore_apd_response                             = var.ha.datastore.apd_response
  ha_datastore_apd_recovery_action                      = var.ha.datastore.apd_recovery_action
  ha_datastore_apd_response_delay                       = var.ha.datastore.apd_response_delay
  ha_admission_control_policy                           = var.ha.admission_control.policy
  ha_admission_control_host_failure_tolerance           = var.ha.admission_control.host_failure_tolerance
  ha_admission_control_performance_tolerance            = var.ha.admission_control.performance_tolerance
  ha_admission_control_resource_percentage_auto_compute = var.ha.admission_control.resource_percentage_auto_compute
  ha_admission_control_resource_percentage_cpu          = var.ha.admission_control.resource_percentage_cpu
  ha_admission_control_resource_percentage_memory       = var.ha.admission_control.resource_percentage_memory
  ha_admission_control_slot_policy_use_explicit_size    = var.ha.admission_control.slot_policy_use_explicit_size
  ha_admission_control_slot_policy_explicit_cpu         = var.ha.admission_control.slot_policy_explicit_cpu
  ha_admission_control_slot_policy_explicit_memory      = var.ha.admission_control.slot_policy_explicit_memory
  ha_admission_control_failover_host_system_ids         = var.ha.admission_control.failover_host_system_ids
  ha_heartbeat_datastore_ids                            = var.ha.heartbeat.datastore_ids
  ha_heartbeat_datastore_policy                         = var.ha.heartbeat.datastore_policy

  proactive_ha_enabled              = var.proactive.enabled
  proactive_ha_automation_level     = var.proactive.ha_automation_level
  proactive_ha_moderate_remediation = var.proactive.ha_moderate_remediation
  proactive_ha_severe_remediation   = var.proactive.ha_severe_remediation
  proactive_ha_provider_ids         = var.proactive.ha_provider_ids

  vsan_enabled                         = var.vsan.enabled
  vsan_dedup_enabled                   = var.vsan.dedup_enabled
  vsan_compression_enabled             = var.vsan.compression_enabled
  vsan_performance_enabled             = var.vsan.performance_enabled
  vsan_verbose_mode_enabled            = var.vsan.verbose_mode_enabled
  vsan_network_diagnostic_mode_enabled = var.vsan.network_diagnostic_mode_enabled
  vsan_unmap_enabled                   = var.vsan.unmap_enabled
  vsan_remote_datastore_ids            = var.vsan.remote_datastore_ids
  vsan_disk_group {
    cache   = var.vsan.vsan_disk_group.cache
    storage = var.vsan.vsan_disk_group.storage
  }
}