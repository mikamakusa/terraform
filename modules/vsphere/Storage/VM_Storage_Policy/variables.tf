variable "storage_policy" {
  type = map(object({
    description = optional(string)
    tag_rule = list(object({
      tag_category                 = string
      tags                         = list(string)
      include_datastores_with_tags = optional(bool)
    }))
  }))
}