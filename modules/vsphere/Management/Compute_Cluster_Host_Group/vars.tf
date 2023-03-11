variable "host_group" {
  type = map(object({
    compute_cluster_id = string
    host_system_ids    = optional(list(string))
  }))
}