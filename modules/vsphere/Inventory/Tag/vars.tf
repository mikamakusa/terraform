variable "tag" {
  type = map(object({
    category_id = string
    description = optional(string)
  }))
}