variable "authentication_properties" {
  type = object({
    annotation      = string
    name_alias      = string
    description     = string
    def_role_policy = string
    ping_check      = bool
    retries         = string
    timeout         = string
  })
}