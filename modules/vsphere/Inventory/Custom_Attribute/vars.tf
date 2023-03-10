variable "custom_attribute" {
  type = map(object({
    managed_object_type = optional(string)
  }))
}