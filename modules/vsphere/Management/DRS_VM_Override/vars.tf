variable "override" {
  type = object({
    compute_cluster_id   = string
    virtual_machine_id   = string
    drs_enabled          = optional(bool)
    drs_automation_level = optional(string)
  })
}