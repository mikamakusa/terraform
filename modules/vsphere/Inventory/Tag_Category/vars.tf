variable "tag_category" {
  type = map(object({
    description      = optional(string)
    cardinality      = string
    associable_types = list(string)
  }))
}