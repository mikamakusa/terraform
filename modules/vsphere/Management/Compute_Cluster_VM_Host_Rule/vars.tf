variable "host_rule" {
  type = map(object({
    compute_cluster_id            = string
    vm_group_name                 = string
    affinity_host_group_name      = optional(string)
    anti_affinity_host_group_name = optional(string)
    enabled                       = optional(bool)
    mandatory                     = optional(bool)
  }))
}