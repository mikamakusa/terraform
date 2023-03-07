resource "vsphere_datastore_cluster" "datastore_cluster" {
  for_each = var.datastore_cluster
  datacenter_id     = each.value.datacenter_id
  name              = each.key
  folder            = each.value.folder
  tags              = each.value.tags
  custom_attributes = each.value.custom_attributes

  sdrs_enabled                             = var.sdrs.enabled
  sdrs_automation_level                    = var.sdrs.automation_level
  sdrs_default_intra_vm_affinity           = var.sdrs.default_intra_vm_affinity
  sdrs_free_space_threshold                = var.sdrs.free_space_threshold
  sdrs_free_space_threshold_mode           = var.sdrs.free_space_threshold_mode
  sdrs_free_space_utilization_difference   = var.sdrs.free_space_utilization_difference
  sdrs_io_balance_automation_level         = var.sdrs.io_balance_automation_level
  sdrs_io_latency_threshold                = var.sdrs.io_latency_threshold
  sdrs_io_load_balance_enabled             = var.sdrs.io_load_balance_enabled
  sdrs_io_load_imbalance_threshold         = var.sdrs.io_load_imbalance_threshold
  sdrs_io_reservable_iops_threshold        = var.sdrs.io_reservable_iops_threshold
  sdrs_io_reservable_percent_threshold     = var.sdrs.io_reservable_percent_threshold
  sdrs_io_reservable_threshold_mode        = var.sdrs.io_reservable_threshold_mode
  sdrs_load_balance_interval               = var.sdrs.load_balance_interval
  sdrs_policy_enforcement_automation_level = var.sdrs.policy_enforcement_automation_level
  sdrs_rule_enforcement_automation_level   = var.sdrs.rule_enforcement_automation_level
  sdrs_space_balance_automation_level      = var.sdrs.space_balance_automation_level
  sdrs_space_utilization_threshold         = var.sdrs.space_utilization_threshold
  sdrs_vm_evacuation_automation_level      = var.sdrs.vm_evacuation_automation_level
}