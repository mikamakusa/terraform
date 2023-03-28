variable "domain" {
  type = map(object({
    description = optional(string)
    annotation  = optional(string)
    name_alias  = optional(string)
  }))
}