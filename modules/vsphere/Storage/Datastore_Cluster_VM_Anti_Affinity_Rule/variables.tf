variable "anti_affinity_rule" {
  type = map(object({
    datatore_cluster_id = string
    virtual_machine_ids = string
    enabled             = optional(bool)
    mandatory           = optional(bool)
  }))
}