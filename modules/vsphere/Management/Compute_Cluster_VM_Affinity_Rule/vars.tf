variable "affinity_rule" {
  type = map(object({
    compute_cluster_id  = string
    virtual_machine_ids = list(string)
    enabled             = optional(bool)
    mandatory           = optional(bool)
  }))
}