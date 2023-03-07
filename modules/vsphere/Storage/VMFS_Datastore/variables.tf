variable "vmfs_datastore" {
  type = map(object({
    disks = string
    host_system_id = string
    folder = optional(string)
    datastore_cluster_id = optional(string)
    tags = optional(list(string))
  }))
}