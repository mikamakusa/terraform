variable "vm_group" {
  type = map(object({
    compute_cluster_id = string
    virtual_machine_ids = optional(list(string))
  }))
}