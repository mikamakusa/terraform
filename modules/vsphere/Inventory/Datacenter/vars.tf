variable "datacenter" {
  type = map(object({
    folder = optional(string)
    tags = optional(list(string))
    custom_attributes = optional(map(string))
  }))
}