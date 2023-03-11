variable "override" {
  type = object({
    compute_cluster_id   = string
    host_system_id       = string
    dpm_enabled          = optional(bool)
    dpm_automation_level = optional(string)
  })
}