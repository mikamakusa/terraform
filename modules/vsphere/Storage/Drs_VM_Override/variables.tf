variable "drs_vm_overrides" {
  type = object({
    datastore_cluster_id   = string
    virtual_machine_id     = string
    sdrs_enabled           = optional(bool)
    sdrs_automation_level  = optional(string)
    sdrs_infra_vm_affinity = optional(string)
  })
}