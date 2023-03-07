variable "datastore_cluster" {
  type = map(object({
    datacenter_id     = string
    folder            = optional(string)
    tags              = optional(list(string))
    custom_attributes = optional(map(string))
  }))
}

variable "sdrs" {
  type = object({
    enabled                                  = optional(bool)
    automation_level                    = optional(string)
    default_intra_vm_affinity           = optional(string)
    free_space_threshold                = optional(number)
    free_space_threshold_mode           = optional(string)
    free_space_utilization_difference   = optional(number)
    io_balance_automation_level         = optional(string)
    io_latency_threshold                = optional(number)
    io_load_balance_enabled             = optional(bool)
    io_load_imbalance_threshold         = optional(number)
    io_reservable_iops_threshold        = optional(number)
    io_reservable_percent_threshold     = optional(number)
    io_reservable_threshold_mode        = optional(string)
    load_balance_interval               = optional(number)
    policy_enforcement_automation_level = optional(string)
    rule_enforcement_automation_level   = optional(string)
    space_balance_automation_level      = optional(string)
    space_utilization_threshold         = optional(number)
    vm_evacuation_automation_level      = optional(string)
  })
  default = {}
}