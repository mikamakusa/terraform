variable "role" {
  type = map(object({
    role_privileges = optional(list(string))
  }))
}