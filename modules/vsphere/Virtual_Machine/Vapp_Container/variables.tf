variable "vapp" {
  type = map(object({
    parent_resource_pool_id = string
    parent_folder_id        = optional(string)
    cpu_share_level         = optional(string)
    cpu_shares              = optional(number)
    cpu_reservation         = optional(number)
    cpu_expandable          = optional(number)
    cpu_limit               = optional(number)
    memory_share_level      = optional(string)
    memory_shares           = optional(number)
    memory_reservation      = optional(number)
    memory_expandable       = optional(number)
    memory_limit            = optional(number)
  }))
}

variable "tags" {
  type = list(string)
}