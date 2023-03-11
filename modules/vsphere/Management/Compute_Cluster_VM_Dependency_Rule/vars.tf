variable "dependency_rule" {
  type = map(object({
    compute_cluster_id = string
    dependency_vm_group_name = string
    vm_group_name = string
    enabled = optional(bool)
    mandatory = optional(bool)
  }))
}