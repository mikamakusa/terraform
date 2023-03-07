variable "nas_datastore" {
  type = map(object({
    host_system_ids      = list(string)
    remote_hosts         = list(string)
    remote_path          = string
    type                 = optional(string)
    access_mode          = optional(string)
    security_type        = optional(string)
    folder               = optional(string)
    datastore_cluster_id = optional(string)
    tags                 = optional(list(string))
    custom_attributes    = optional(map(string))
  }))
}