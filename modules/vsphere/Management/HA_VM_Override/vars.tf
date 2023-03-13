variable "compute_cluster_id" {
  type = string
}

variable "virtual_machine_id" {
  type = string
}

variable "general_ha" {
  type = object({
    ha_vm_restart_priority     = optional(string)
    ha_vm_restart_timeout      = optional(string)
    ha_host_isolation_response = optional(string)
  })
  default = {}
}

variable "ha_virtual_machine" {
  type = object({
    ha_datastore_pdl_response        = optional(string)
    ha_datastore_apd_response_delay  = optional(string)
    ha_datastore_apd_response        = optional(string)
    ha_datastore_apd_recovery_action = optional(string)
  })
  default = {}
}

variable "monitoring_settings" {
  type = object({
    ha_vm_monitoring                      = optional(string)
    ha_vm_monitoring_use_cluster_defaults = optional(bool)
    ha_vm_failure_interval                = optional(number)
    ha_vm_minimum_uptime                  = optional(number)
    ha_vm_maximum_resets                  = optional(number)
    ha_vm_maximum_failure_window          = optional(string)
  })
  default = {}
}