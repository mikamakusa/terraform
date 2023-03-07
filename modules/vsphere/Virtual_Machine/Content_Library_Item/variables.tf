variable "item" {
  type = map(object({
    name        = string
    library_id  = string
    file_url    = optional(string)
    source_uuid = optional(string)
    description = optional(string)
    type        = optional(string)
  }))
}