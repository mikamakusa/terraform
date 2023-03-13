variable "cluster" {
  type = map(object({
    datacenter_id     = string
    folder            = optional(string)
    tags              = optional(list(string))
    custom_attributes = optional(map(string))
  }))
}

variable "host_management" {
  type = object({
    host_system_ids           = optional(list(string))
    host_managed              = optional(bool)
    host_cluster_exit_timeout = optional(number)
    force_evacuate_on_destroy = optional(bool)
  })
  default = {}
}

variable "drs" {
  type = object({
    enabled                  = optional(bool)
    automation_level         = optional(string)
    migration_threshold      = optional(number)
    enable_vm_overrides      = optional(bool)
    enable_predictive_drs    = optional(bool)
    scale_descendants_shares = optional(bool)
    advanced_options         = optional(map(string))
  })
  description = "DRS configuration for this cluster"
  default     = {}
}

variable "dpm" {
  type = object({
    enabled          = optional(bool)
    automation_level = optional(string)
    threshold        = optional(number)
  })
  description = "DPM - Distributed Power Management - configuration for this cluster"
  default     = {}
}

variable "ha" {
  type = object({
    enabled = optional(bool)
    host = optional(object({
      monitoring         = optional(string)
      isolation_response = optional(string)
    }))
    vm = optional(object({
      restart_priority             = optional(string)
      dependency_restart_condition = optional(string)
      restart_additional_delay     = optional(number)
      restart_timeout              = optional(number)
      isolation_response           = optional(string)
      component_protection         = optional(string)
      monitoring                   = optional(string)
      failure_interval             = optional(number)
      minimum_uptime               = optional(number)
      maximum_resets               = optional(number)
      maximum_failure_window       = optional(number)
      advanced_options             = optional(map(string))
    }))
    datastore = optional(object({
      pdl_response        = optional(string)
      apd_response        = optional(string)
      apd_recovery_action = optional(string)
      apd_response_delay  = optional(number)
    }))
    admission_control = optional(object({
      policy                           = optional(string)
      host_failure_tolerance           = optional(number)
      performance_tolerance            = optional(number)
      resource_percentage_auto_compute = optional(bool)
      resource_percentage_cpu          = optional(number)
      resource_percentage_memory       = optional(number)
      slot_policy_use_explicit_size    = optional(bool)
      slot_policy_explicit_cpu         = optional(number)
      slot_policy_explicit_memory      = optional(number)
      failover_host_system_ids         = optional(list(string))
    }))
    heartbeat = optional(object({
      datastore_ids    = optional(list(string))
      datastore_policy = optional(string)
    }))
  })
  default = {}
}

variable "proactive" {
  type = object({
    enabled                 = optional(bool)
    ha_automation_level     = optional(string)
    ha_moderate_remediation = optional(string)
    ha_severe_remediation   = optional(string)
    ha_provider_ids         = optional(list(string))
  })
  default = {}
}

variable "vsan" {
  type = object({
    enabled                         = optional(bool)
    dedup_enabled                   = optional(bool)
    compression_enabled             = optional(bool)
    performance_enabled             = optional(bool)
    verbose_mode_enabled            = optional(bool)
    network_diagnostic_mode_enabled = optional(bool)
    unmap_enabled                   = optional(bool)
    remote_datastore_ids            = optional(list(string))
    vsan_disk_group = optional(object({
      cache   = optional(string)
      storage = optional(map(string))
    }))
  })
  default = {}
}