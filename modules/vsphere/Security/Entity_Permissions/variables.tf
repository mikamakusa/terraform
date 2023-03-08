variable "permission" {
  type = object({
    entity_id   = string
    entity_type = string
    permission = object({
      user_or_group = string
      propagate     = bool
      is_group      = bool
      role_id       = string
    })
  })
}