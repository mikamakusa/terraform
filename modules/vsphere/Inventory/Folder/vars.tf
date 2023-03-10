variable "folder" {
  type = object({
    path              = string
    type              = string
    datacenter_id     = optional(string)
    tags              = optional(list(string))
    custom_attributes = optional(map(string))
  })
}