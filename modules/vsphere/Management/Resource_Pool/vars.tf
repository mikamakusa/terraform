variable "resource_pool" {
  type = map(object({
    parent_resource_pool_id = string
  }))
}

variable "config" {
  type = object({
    cpu_share_level    = optional(string)
    cpu_expandable     = optional(bool)
    cpu_limit          = optional(string)
    cpu_reservation    = optional(number)
    cpu_shares         = optional(string)
    memory_expandable  = optional(bool)
    memory_limit       = optional(string)
    memory_reservation = optional(number)
    memory_share_level = optional(string)
    memory_shares      = optional(string)
    tags               = optional(list(string))
  })
}